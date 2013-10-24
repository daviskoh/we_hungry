class PlaylistFoodsController < ApplicationController
  def show
    @food = PlaylistFood.find(params[:id])
  end

  def like
    get_user_and_food

    @pair[:user]
    # binding.pry
  end

  def dislike
    get_user_and_food
    # currently: playlist_food, ingredients,
    # playlist_food_ingredient,
    # ingredient_user

    # dislike playlist_food_user
  end

  def get_user_and_food
    @pair = {}
    @pair[:user] = User.find(params[:user_id])
    @pair[:playlist_food] = PlaylistFood.find(params[:id])
    @pair
  end
end
