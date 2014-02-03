class PlaylistFoodsController < ApplicationController
  include RecommendationsHelper
  before_action :get_food_info

  def show
  end

  #TODO change below to api

  def like
    binding.pry
    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.pos_votes += 1
      relation.tot_votes += 1
      relation.save
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    redirect_to user_path(current_user)
  end

  def dislike
    binding.pry
    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.tot_votes += 1
      relation.save
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    redirect_to user_path(current_user)
  end

  private

  def get_food_info
    @food = PlaylistFood.find(params[:id])
  end
end
