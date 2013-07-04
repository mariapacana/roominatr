class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    question = @survey.questions.build
    3.times { question.answers.build }
  end

  def create
    p category = Category.find_by_name(params[:survey][:category])
    params[:survey][:category] = category
    Survey.create(params[:survey])
  end

end
