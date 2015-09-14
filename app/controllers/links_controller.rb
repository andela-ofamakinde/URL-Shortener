class LinksController < ApplicationController
  # before_action :set_link, only: [:show]
  respond_to :html, :js
  def index
   @links = Link.all
  end  
  def new
   @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = @current_user.id if current_user
    if @link.save
        respond_to do |format|
        # format.html redirect_to root_path
        format.js 
      end
    else
      flash[:failure] = "short url not created"
    end
  end

  def show
    if params[:short_url]
      # require "pry-nav"; binding.pry
      @link = Link.find_by(short_url: params[:short_url])
      if redirect_to @link.long_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
    end
  end

  private

  def link_params
    params.require(:link).permit(:long_url)
  end

  def set_link
    @link = Link.find_by(short_url: params[:short_url])
  end

end
