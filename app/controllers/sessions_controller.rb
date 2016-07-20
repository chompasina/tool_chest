class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    # require "pry"; binding.pry
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Congrats, you're logged in!"
      redirect_to user_path(user)
    else
      flash[:alert] = "invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
