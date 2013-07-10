class SurveysController < ApplicationController

  include SessionsHelper

  def new
    @survey = Survey.new
    question = @survey.questions.build
    3.times { question.answers.build }
  end

  def create
    category = Category.find_by_name(params[:survey][:category])
    params[:survey][:category] = category
    @survey = Survey.new(params[:survey])

    if @survey.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
    @user = current_user
  end

end
