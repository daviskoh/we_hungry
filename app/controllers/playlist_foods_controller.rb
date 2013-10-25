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
      binding.pry
    end

    PlaylistFoodsUsers.where(user_id: current_user.id, playlist_food_id: @food.id)[0].destroy

    redirect_to user_path(current_user)
  end

  def dislike
    get_user_and_food
    # currently: playlist_food, ingredients,
    # playlist_food_ingredient,
    # ingredient_user

    # dislike playlist_food_user
  end

  def get_food_info
    @food = PlaylistFood.find(params[:id])
    @food
  end
end
