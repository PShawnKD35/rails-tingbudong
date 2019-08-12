class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def update
    set_user
    authorize @user
    if @user.update!(params.require(:user).permit(:email, :name, :avatar_url))
      @user.update!(is_new: false)
      head :no_content 
    end
  end
  
  def show
    format_time
    set_user
    authorize @user
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end

end