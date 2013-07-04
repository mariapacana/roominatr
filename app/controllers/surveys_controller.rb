class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    question = @survey.questions.build
    3.times { question.answers.build }
  end

  def create
    p survey = Survey.create(params[:survey])
    p survey.questions
    # survey = Survey.new(params[:name])
    # question = @survey.questions.build

    # category
    # survey name
    # question name
    # options


  end

end
