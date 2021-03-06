class ListingsController < ApplicationController
  def index
  	@listings = Listing.order(created_at: :asc)
  end

  def show
  	@listing = Listing.find params[:id]
    @user = @listing.user
  end

  def new 
  	@listing = Listing.new
    @subtopics = Subtopic.all
    @user_zip_code = current_user.zip_code
    @meeting_types = ["In-person", "Virtual", "Both"]
  end

  def create
    if user_signed_in? 
      safe_listing = params.require(:listing).permit(:title, :description, :subtopic_id, :meeting_type, :address, :latitude, :longitude).merge(user_id: current_user.id)
      @listing = Listing.create safe_listing
      @subtopics = Subtopic.all
      @user_zip_code = current_user.zip_code
      @meeting_types = ["In-person", "Virtual", "Both"]
      @listing.save ? redirect_to(@listing) : render("new")
    else
      redirect_to new_user_session_path, alert: "Only logged in users can create listings." 
    end
  end

  def edit
    @listing = Listing.find params[:id]
    @subtopics = Subtopic.all
    @user_zip_code = current_user.zip_code
    if current_user != @listing.user
      flash[:alert] = "You are not authorized to execute this action"
      redirect_to root_path
    end
  end

  def update
    @listing = Listing.find params[:id]
    safe_listing = params.require(:listing).permit(:title, :description, :subtopic_id, :meeting_type, :address, :latitude, :longitude).merge(user_id: @listing.user.id)
    @listing.update safe_listing
    redirect_to @listing
  end
  def destroy
      @listing = (Listing.find params[:id])
    if current_user == @listing.user
      @listing.destroy
      flash[:alert] = "Successully deleted listing"
      redirect_to root_path
    else 
      flash[:alert] = "You are not authorized to execute this action"
      redirect_to root_path
    end
  end
end
