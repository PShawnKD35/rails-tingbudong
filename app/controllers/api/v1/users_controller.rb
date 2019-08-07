class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def update
    @user = User.find(params[:id])
    authorize @user
    head :no_content if @user.update!(params.require(:user).permit(:email, :name, :avatar_url))
  end
end