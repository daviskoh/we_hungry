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
    if @user.save

      redirect_to user_path(@user)
    # return to signup page
    else
      render :new
    end
  end

  def show
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

  def generate_recommendation
    # # generate_food 
    # gen_preferred_food

    # add_to_user_foodlist(@food)

    # @food.ingredients.each do |ing|
    #   add_to_user_ingredients(ing) unless user_has_ingredient?(ing)
    # end

    # redirect_to user_path(current_user)
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