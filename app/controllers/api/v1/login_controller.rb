class Api::V1::LoginController < Api::V1::BaseController
  # skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized, :verify_policy_scoped

  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze

  def wechat_user
    wechat_params = {
      appId: ENV['appId'],
      secret: ENV['secret'],
      js_code: params[:code],
      grant_type: "authorization_code"
    }

    @wechat_response ||= RestClient.get(URL, params: wechat_params)
    @wechat_user ||= JSON.parse(@wechat_response.body)
  end

  def login
    domain = "@tingbudong.net"
    wechat_user_info = wechat_user
    if wechat_user_info["openid"].present?
      openid = wechat_user_info.fetch("openid")
      @user = User.find_by(wechat_id: openid)
      unless @user.present?
        @user = User.new(wechat_id: openid, email: "#{openid}#{domain}")
        @user.save!
        @user.update!(email: "#{@user.id}#{domain}")
      end
      @user.reload.authentication_token
      render json: {
        userId: @user.id,
        email: @user.email,
        userToken: @user.authentication_token,
        isNew: @user.is_new
      }
    else
      render json: wechat_user_info
    end
  end
end
