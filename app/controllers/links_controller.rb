include Geokit::Geocoders
class LinksController < ApplicationController
  respond_to :html, :js

  def index
   @links = Link.all.paginate(page: params[:page], :per_page => 10)
  end  

  def new
    @link = Link.new
    @top_links = Link.first(5)
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = @current_user.id if current_user
    if @link.save
      respond_to do |format|
        format.js
        format.json { render action: 'show', status: :created, location: @link }
      end
    else
      flash[:failure] = "Short URL not created, enter correct URL format"
    end
  end

  def show
    if params[:short_url]
      @link = Link.find_by(short_url: params[:short_url])
      redirect_to @link.long_url
      @link.track_visits(request)
     end
  end

  def link_details
    @link = Link.find(params[:id])
    @link_analytics = @link.analytic
  end

  private

  def link_params
    params.require(:link).permit(:long_url)
  end

end
