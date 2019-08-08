class Api::V1::SlangsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :tags ]
  before_action :set_slang, only: [:show, :update]
  skip_after_action :verify_policy_scoped, only: :index

  def index
    if params[:name].present?
      @slangs = Slang.where("name LIKE ?", "%#{params[:name]}%")
    else
      # @slangs = policy_scope(Slang)
      @slangs = Slang.limit(10)
    end
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    render json: @tags
  end
  
  def show
    @definitions = @slang.definitions
    # puts "=========="
    # p user_signed_in?
    # p current_user
    # puts "=========="
    # if user_signed_in?
      # authorize @slang
      # authorize @definitions
      @current_user_id = current_user.id
      # authorize @current_user_id
    # end
    # render json: @slang
  end

  def create
    @slang = Slang.new(slang_params)
    @slang.user = current_user
    authorize @slang
    render json: { slang_id: @slang.id } if @slang.save!
  end

  def update
    authorize @slang
    render json: @slang if @slang.update!(slang_params)
  end

  private
  
  def set_slang
    @slang = Slang.find(params[:id])
    authorize @slang
  end

  def slang_params
    params.require(:slang).permit(:name, :sticker_url)
  end
end