class LinksController < ApplicationController
  before_action :set_link, only: [:show]
  respond_to :html, :js
  def index
   @links = Link.all.order(created_at: :desc)
  end  
  def new
   @link = Link.new
    @top_links = Link.order(clicks: :desc).first(12)
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = @current_user.id if current_user
    if @link.save
        respond_to do |format|
        # format.html redirect_to root_path
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
      if redirect_to @link.long_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
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
