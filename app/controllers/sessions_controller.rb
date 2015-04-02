class SessionsController < ApplicationController
  def index
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to root_path
    else
      flash[:error] = 'Email or Password incorrect...'
      redirect_to sessions_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
