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
      render :new
    end
  end

  def show
    @user = current_user
    @house = @user.house
  end

  def edit
    @user = current_user
    @house = @user.house
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(params[:house])
      redirect_to user_house_path(current_user, @house)
    else
      render :edit
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to user_path(current_user)
  end

  def default_image
    render :text => open("#{Rails.root}/app/assets/images/default_home.jpg", "rb").read
  end

end