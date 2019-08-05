class Api::V1::SlangsController < Api::V1::BaseController
  def index
    @slangs = policy_scope(Slang)
    render json: @slangs
  end
  
  def show
    @slang = Slang.find(params[:id])
    authorize @slang
    # render json: @slang
  end
end