class Api::V1::SlangsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index ]
  before_action :set_slang, only: [:show, :update]

  def index
    @slangs = policy_scope(Slang)
    render json: @slangs
  end
  
  def show
    @definitions = @slang.definitions
    authorize @slang
    @current_user_id = current_user.id if user_signed_in?
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
    params.require(:slang).permit(:name)
  end
end