class PlaylistFoodsController < ApplicationController
  def show
    @show = PlaylistFood.find(params[:id])
  end
end