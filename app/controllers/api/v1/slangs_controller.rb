class Api::V1::SlangsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_slang, only: [:show, :update]

  def index
    @slangs = policy_scope(Slang)
    render json: @slangs
  end
  
  def show
    # render json: @slang
  end

  def create
    @slang = Slang.new(slang_params)
    @slang.user = current_user
    authorize @slang
    render json: { slang_id: @slang.id } if @slang.save!
  end

  def update
    render json: @slang
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