class SurveysController < ApplicationController

  include SessionsHelper

  def new
    @survey = Survey.new
    question = @survey.questions.build
    3.times { question.answers.build }
  end

  def create
    p params
    category = Category.find_by_name(params[:survey][:category])
    params[:survey][:category] = category
    Survey.create(params[:survey])
  end

  def show
    @survey = Survey.find(params[:id])
    @user = current_user
  end

end
