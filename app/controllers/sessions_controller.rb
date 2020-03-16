class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:danger] = 'you already have active session'
      redirect_to root_path
    end
  end

  def create
    if logged_in?
      flash[:danger] = 'you already have active session'
      redirect_to root_path
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        flash[:success] = 'welcome '+current_user.name
        redirect_to root_path
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    log_out
    session[:created] = false
    redirect_to root_url
  end
  
end