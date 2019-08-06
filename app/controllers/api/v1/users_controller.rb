class Api::V1::UsersController < Api::V1::BaseController
  def update
    @user = User.find(params[:id])
    authorize @user
    head: :no_content if @user.update!(params.require(:user).permit(:email))
  end
end