class UsersController < ApplicationController

	include SessionsHelper
	include UsersHelper
	include AjaxHelper

	def index
		if current_user.no_surveys?
			flash.now[:error] = "Please answer some Questions!"
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		create_category_scores(@user)
		if @user.save
			flash[:success] = "Welcome to Roominatr"
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
		if params[:gender] == ""
			users = User.scoped
		else 
			users = User.where(gender: params[:gender])
		end
		@users = users.filter_by_age(params[:age_min], params[:age_max])
		render_partial('show_users', 'index', { :users => @users })
	end

	def default_image
		render :text => open("#{Rails.root}/app/assets/images/default_pic.gif", "rb").read
	end

end
