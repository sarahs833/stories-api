class Api::V1::StoriesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token, only: [:create,:update]
  before_action :set_story, only: [:show, :update]
  def index
    @stories = Story.all   #Just for testing
  end
  def show
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      render :show, status: :created
    else
      render_error
    end

    def update
     if @story.update(story_params)
        render :show
      else
        render_error
      end
    end
  end

  private
    def story_params
    params.require(:story).permit(:name, :text)
  end

  def render_error
    render json: { errors: @story.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_story
    @story = Story.find(params[:id])
  end
end
