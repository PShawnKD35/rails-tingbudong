class Api::V1::FavoritesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  skip_after_action :verify_policy_scoped, only: :index

  def index
    format_time
    @slangs = current_user.favorited_by_type('Slang')
  end

  def create
    head :created if current_user.favorite(set_slang)
  end

  def destroy
    head :no_content if current_user.unfavorite(set_slang)
  end

  private

  def set_slang
    slang = Slang.find(params.permit(:slang_id)[:slang_id])
    authorize slang
    return slang
  end
end
