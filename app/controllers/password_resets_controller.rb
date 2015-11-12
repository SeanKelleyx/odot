class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      flash[:notice] = "Check your email to reset your password."
      redirect_to login_path
    else
      flash[:error] = "Email #{params[:email]} not found, please try again."
      render action: "new"
    end
  end

end
