class UsersController < ApplicationController
  include UsersHelper 
  # need these before user actions
  # except new & create because initiating
  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]
  # authenticated! provided by SessionsHelper

  def new
    @user = User.new

    # when user created
    # 10.times do { self.generate_recommendation }



      # user vote like / dislike
        # if dislike
          # add to unliked_foods
          # establish user ingredient relation
          # increment relation by -1
          # delete playlist food ingredient relation
          # delete playlist food
        # if like

        # end

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

  def show
    binding.pry
    render :show
  end

  def edit
    render :edit
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

  # custom routes

  def generate_recommendation
    # retrieve food meeting algo & allergies

    api_call

    # add appropriate data to db tables
    insert_api_call_to_db

    redirect_to user_path(current_user)
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