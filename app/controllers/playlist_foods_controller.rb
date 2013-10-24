class PlaylistFoodsController < ApplicationController
  def show
    @food = PlaylistFood.find(params[:id])
  end

  def dislike
    user = User.find(params[:user_id])
    playlist_food = PlaylistFood.find(params[:id])
  end
end