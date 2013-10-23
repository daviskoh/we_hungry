class PlaylistFood < ApplicationController
  def show
    @show = PlaylistFood.find(params[:id])
  end
end