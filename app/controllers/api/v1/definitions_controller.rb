class Api::V1::DefinitionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def create
    @definition = Definition.new(params.require(:definition).permit(:content, :sticker_url))
    @definition.user = current_user
    @definition.slang_id = params[:slang_id]
    authorize @definition
    render json: { definition_id: @definition.id} if @definition.save!
  end

  def like
    @like = Like.new(params.require(:like).permit(:slang_id))
    @like.user = current_user
    authorize @like, policy_class: DefinitionPolicy
    render json: {like_id: @like.id} if @like.save!
  end

  def unlike
  end
end