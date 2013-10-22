class UsersController < ApplicationController
  # need these before user actions
  # except new & create because initiating
  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]
  # authenticated! provided by SessionsHelper

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    # user successfully create
    if @user.save
      redirect_to user_path(@user)
    # return to signup page
    else
      render :new
    end
  end
  
  # helper methods
  private

  # whitelist
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end
end