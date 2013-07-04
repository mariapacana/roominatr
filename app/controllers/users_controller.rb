class UsersController < ApplicationController

	include SessionsHelper

	def new
		@user = User.new
		p '########HERE#######'
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			p '==============='
			p @user
			flash[:sucess] = "Welcome to Roominatr"
			sign_in(@user)
			render :show
		else
			flash[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user 
	end

	def edit
		@user
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile Updated!"
			redirect_to @user
		else
			flash[:erros] = @user.errors.full_messages
			render :edit
		end
	end

	def destroy
		sign_out
		User.destroy(params[:id])
		redirect_to new_user_path
	end

end