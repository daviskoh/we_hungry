class UsersController < ApplicationController
  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @reco_list = @user.playlist_foods.reverse
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to new_user_path
    else
      render :edit
    end
  end

  # helper methods
  private

  # security ########
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :vege, :vegan, :lactose, :nut)
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