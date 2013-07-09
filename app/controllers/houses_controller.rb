class HousesController < ApplicationController

  include SessionsHelper

  def new
    @user = current_user
    @house = @user.build_house
    @house.build_location
  end

  def create
    @house = current_user.build_house(params[:house])
    if @house.save
      redirect_to user_path(current_user)
    else

    end
  end

end