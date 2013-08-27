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
    @user = User.find(params[:user_id])
    @house = @user.house
  end

  def edit
    @user = current_user
    @house = @user.house
  end

  def update
    @house = current_user.house
    if @house.update_attributes(params[:house])
      redirect_to user_houses_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @house = current_user.house
    @house.destroy
    redirect_to user_path(current_user)
  end

  def default_image
    render :text => open("#{Rails.root}/app/assets/images/default_home.jpg", "rb").read
  end


end