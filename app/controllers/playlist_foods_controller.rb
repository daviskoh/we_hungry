class PlaylistFoodsController < ApplicationController
  include RecommendationsHelper
  before_action :get_food_info

  def show
  end

  def like
    # binding.pry
    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.pos_votes += 1
      relation.tot_votes += 1
      relation.save
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    render json: @food, status: 200
  end

  def dislike
    # binding.pry
    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.tot_votes += 1
      relation.save
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    render json: @food, status: 200
  end

  private

  def get_food_info
    @food = PlaylistFood.find(params[:id])
  end
end
