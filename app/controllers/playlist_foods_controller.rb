class PlaylistFoodsController < ApplicationController
  include UsersHelper

  def show
    @food = PlaylistFood.find(params[:id])
  end

  def like
    get_food_info

    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.pos_votes += 1
      relation.tot_votes += 1
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    redirect_to user_path(current_user)
  end

  def dislike
   get_food_info

    @food.ingredients.each do |ing|
      relation = IngredientsUsers.where(user_id: current_user.id, ingredient_id: ing.id)[0]
      relation.pos_votes -= 1 unless relation.pos_votes == 0
      relation.tot_votes += 1
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    redirect_to user_path(current_user)
  end

  def get_food_info
    @food = PlaylistFood.find(params[:id])
    @food
  end
end
