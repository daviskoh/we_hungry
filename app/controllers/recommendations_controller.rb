class RecommendationsController < ApplicationController
  include RecommendationsHelper
  before_action :authenticated!, :set_user, :authorized!

  def generate
    # expire cache from specified in UsersController
    # expire_action controller: '/users', action: :show

    # generate_food 
    reco = unless current_user.ingredients.count < 2
      gen_preferred_food 
    else
      PlaylistFood.order('random()').first
    end

    # binding.pry

    current_user.playlist_foods << reco

    reco.ingredients.each do |ing|
      current_user.ingredients << ing unless user_has_ingredient?(ing)
    end

    render json: reco, status: 200
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end
end