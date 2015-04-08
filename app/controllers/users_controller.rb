class UsersController < ApplicationController

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def show
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:message] = "User was udpated successfully..."
    else
      flash[:message] = "User was updated failure..."
    end
    redirect_to edit_user_path
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      flash[:message] = "User was deleted successfully..."
    else
      flash[:message] = "User was deleted failure..."
    end
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
    end

end
