include Geokit::Geocoders
class LinksController < ApplicationController
  before_action :set_link, only: [:show]
  respond_to :html, :js

  def index
   @links = Link.all.order(created_at: :desc)
  end  

  def new
    @link = Link.new
    @top_links = Link.order(clicks: :desc).first(5)
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
      flash[:failure] = "short url not created, enter correct url format"
    end
  end

  def show
    if params[:short_url]
      @link = Link.find_by(short_url: params[:short_url])
      redirect_to @link.long_url
      @link.track_visits(request)
        # @link.save
     end
  end

  def link_details
    @link = Link.find(params[:id])
  end

  private

  def link_params
    params.require(:link).permit(:long_url)
  end

  def set_link
    @link = Link.find_by(short_url: params[:short_url])
  end

end
