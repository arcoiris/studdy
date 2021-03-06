class TopicsController < ApplicationController

  def index
    @topics =Topic.all
  end
  
  def new
    @topic = Topic.new 
  end

  def create
    safe_topic = params.require(:topic).permit(:name)
    @topic = Topic.create safe_topic
    redirect_to @topic 
  end

  def show
    @topic = Topic.find params[:id]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
