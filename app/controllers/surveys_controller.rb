class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    @survey.questions.build
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
