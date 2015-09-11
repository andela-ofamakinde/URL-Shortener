class LinksController < ApplicationController
  respond_to :html, :js
  def index
   @links = Link.all
   @link = Link.new
  end  
  def new
   
  end

  def create
    @link = Link.new(link_params)
    # require "pry-nav"; binding.pry
    if @link.save
      @last_link = "#{root_url}" + Link.last.short_url 
        respond_to do |format|
        # format.html redirect_to root_path
        format.js 
      end
    else
      flash[:failure] = "short url not created"
    end
  end

  def show
    @link = Link.all
  end

  private

  def link_params
    params.require(:link).permit(:long_url)
  end
end
