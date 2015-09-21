class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if logged_in? && @user == current_user
      @links = @user.links.paginate(page: params[:page], :per_page => 5)
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{user_params[:name]} to URL shortner!"
      redirect_to root_path
    else
      flash[:error] = "One or more required fields are missing"
      render "new"
    end
  end

  private

  def user_params
   params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end 
end
