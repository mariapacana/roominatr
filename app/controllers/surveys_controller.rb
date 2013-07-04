class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    question = @survey.questions.build
    3.times { question.answers.build }
  end

  def create
    Survey.create(params[:survey])
  end

end
