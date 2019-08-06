class Api::V1::DefinitionsController < Api::V1::BaseController
  def create
    @definition = Definition.new(params.require(:definition).permit(:content, :sticker_url))
    @definition.user = current_user
    @definition.slang_id = params[:slang_id]
    authorize @definition
    render json: { definition_id: @definition.id} if @definition.save!
  end

  def like
  end

  def unlike
  end
end