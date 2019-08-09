class Api::V1::SlangsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :tags ]
  skip_after_action :verify_policy_scoped, only: :index
  
  before_action :set_slang, only: [:show, :update, :destroy]
  before_action :format_time, only: [:index, :show, :add_tag, :remove_tag]

  def index
    if params[:tag].present?
      @slangs = Slang.tagged_with(params[:tag]).limit(10)
    elsif params[:name].present?
      @slangs = Slang.where("name ILIKE ?", "%#{params[:name]}%")
    else
      # @slangs = policy_scope(Slang)
      @slangs = Slang.limit(10)
    end
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    authorize @tags, policy_class: SlangPolicy
    render json: @tags
  end

  def add_tag
    set_tag_params
    @slang.tag_list.add(@args[:tag_name]) if @args[:tag_name].present?
    @slang.dialect_list.add(@args[:dialect_name]) if @args[:dialect_name].present?
    render :show, status: :created if @slang.save!
  end

  def remove_tag
    set_tag_params
    @slang.tag_list.remove(@args[:tag_name]) if @args[:tag_name].present?
    @slang.dialect_list.remove(@args[:dialect_name]) if @args[:dialect_name].present?
    render :show if @slang.save!
  end
  
  def show
    @definitions = @slang.definitions
    # puts "=========="
    # p user_signed_in?
    # p current_user
    # puts "=========="
    # if user_signed_in?
      # authorize @slang
      # authorize @definitions
      @current_user_id = current_user.id
      # authorize @current_user_id
    # end
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

  def destroy
    authorize @slang
    head :no_content if @slang.destroy!
  end

  private
  
  def set_slang
    @slang = Slang.find(params[:id])
    authorize @slang
  end

  def slang_params
    params.require(:slang).permit(:name, :sticker_url)
  end

  def format_time
    @format_time = lambda { |time| time.strftime("%Y.%-m.%-d") }
  end

  def set_tag_params
    @args = params.require('tag').permit(:tag_name, :dialect_name, :slang_id)
    @slang = Slang.find(@args[:slang_id])
    authorize @slang, policy_class: SlangPolicy
  end
end