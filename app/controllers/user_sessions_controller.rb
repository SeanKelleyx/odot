class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Thank you for logging in!"
      redirect_to todo_lists_path
    else
      render action: 'new'
      flash[:error] = "There was a problem logging in. Please check your email and password."
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully Logged Out"
    redirect_to login_path
  end
end
