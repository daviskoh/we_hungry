class PlaylistFoodsController < ApplicationController
  def show
    @food = PlaylistFood.find(params[:id])
  end
end