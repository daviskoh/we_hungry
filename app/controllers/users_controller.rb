class UsersController < ApplicationController
  # need these before user actions
  # except new & create because initiating
  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    
  end
end