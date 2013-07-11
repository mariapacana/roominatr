class UsersController < ApplicationController

	include SessionsHelper
	include UsersHelper
	include AjaxHelper

	def index
		if current_user.no_surveys?
			flash.now[:error] = "Please answer some questions!"
			@top_users = User.all.sample(10)
		else
			@top_users = current_user.top_users(0)
		end
	end

	def new
		@user = User.new
		@user.build_location
	end

	def create
		@user = User.new(params[:user])
		p @user
		# create_category_scores(@user)
		if @user.save
			flash[:success] = "Welcome to Roominator"
			sign_in(@user)
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		p "UPDATING====================="
		
		@user = User.find(params[:id])
		paramz = format_params(params[:user])

		if @user.update_attributes(paramz)
			flash[:success] = "Profile Updated!"
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages
			if paramz[:password]
			 render :edit_user_password
			else
	 		 render :edit
			end
		end
	end

	def update_picture
		@user = User.find(params[:id])
		if @user.update_attribute(:avatar, params[:user][:avatar])
			flash[:success] = "Picture Updated!"
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages
			render :edit
		end
	end

	def edit_password
		@user = User.find(params[:id])
		render :edit_user_password
	end

	def destroy
		sign_out
		User.destroy(params[:id])
		redirect_to new_user_path
	end

	def search
		users = User.scoped
		users = users.older_than(params[:age_min]) unless params[:age_min].blank?
		users = users.younger_than(params[:age_max]) unless params[:age_max].blank?
		users = users.where(gender: params[:gender]) unless params[:gender].blank?
		users = users.joins(:location).where('city = ?', params[:user_city]) unless params[:user_city].blank?
		users = users.cheaper_than(params[:price_max]) unless params[:price_max].blank?
		users = users.more_expensive_than(params[:price_min]) unless params[:price_min].blank?
		users = users.neighborhood(params[:neighborhood]) unless params[:neighborhood].blank?
		users = users.city(params[:city]) unless params[:city].blank?
		users_hash = {}
		users.each do |user|
			users_hash[user]=user.compatibility_with(current_user)
		end
		render_partial('show_users', 'index', { :users => users_hash })
	end

	def search_no_house
		render_partial('no_house', 'search_no_house',{})
	end

	def search_house
		render_partial('house', 'search_house',{})
	end

	def default_image
		render :text => open("#{Rails.root}/app/assets/images/default_image.gif", "rb").read
	end


end
