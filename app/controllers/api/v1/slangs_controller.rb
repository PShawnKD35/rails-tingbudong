class Api::V1::SlangsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :tags ]
  skip_after_action :verify_policy_scoped, only: :index
  
  before_action :set_slang, only: [:show, :update]
  before_action :format_time, only: [:index, :show]

  def index
    if params[:name].present?
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

  private
  
  def set_slang
    @slang = Slang.find(params[:id])
    authorize @slang
  end

  def slang_params
    params.require(:slang).permit(:name, :sticker_url)
  end

  def format_time
    @format_time = lambda { |time| time.strftime("%Y.%-d.%-m") }
  end
end