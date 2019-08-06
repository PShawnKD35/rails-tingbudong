class Api::V1::DefinitionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def create
    @definition = Definition.new(params.require(:definition).permit(:slang_id, :content, :sticker_url))
    @definition.user = current_user
    authorize @definition
    render json: { definition_id: @definition.id} if @definition.save!
  end

  def update
    @definition = Definition.find(params[:id])
    authorize @definition
    head :no_content if @definition.update!(params.require(:definition).permit(:content, :sticker_url))
  end

  def like
    @like = Like.new(params.require(:like).permit(:definition_id))
    @like.user = current_user
    authorize @like, policy_class: DefinitionPolicy
    render json: {like_id: @like.id} if @like.save!
  end

  def unlike
    @like = Like.find(params[:id])
    authorize @like, policy_class: DefinitionPolicy
    head :no_content if @like.destory!
  end
end