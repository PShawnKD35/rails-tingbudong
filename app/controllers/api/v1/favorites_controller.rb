class Api::V1::FavoritesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  skip_after_action :verify_policy_scoped, only: :index

  def index
    format_time
    @slangs = current_user.favorited_by_type('Slang')
    render 'api/v1/slangs/index.json.jbuilder'  # Skip the favorites index for now
  end

  def create
    head :created if current_user.favorite(set_slang)
  end

  def destroy
    head :no_content if current_user.unfavorite(set_slang)
  end

  private

  def set_slang
    slang_id = params.permit(:slang_id)[:slang_id]
    authorize slang_id, policy_class: FavoritePolicy
    slang = Slang.find(slang_id)
    return slang
  end
end
