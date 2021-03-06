class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate that user/pass combo is legit
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      @error = 'Incorrect email & password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(new_session_path)
  end
end