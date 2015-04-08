class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to root_path
    else
      flash[:error] = "Email or Password incorrect..."
      redirect_to new_session_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
