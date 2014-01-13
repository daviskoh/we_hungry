class RecommendationsController < ApplicationController
  include RecommendationsHelper
  before_action :authenticated!, :set_user, :authorized!

  def generate
    # generate_food 
    gen_preferred_food

    add_to_user_foodlist(@food)

    @food.ingredients.each do |ing|
      add_to_user_ingredients(ing) unless user_has_ingredient?(ing)
    end

    render json: @food
  end

  private

  # security ########
  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end
end