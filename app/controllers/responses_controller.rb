class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end

  def create
    @survey = Survey.find params[:survey_id]
    @submission = Submission.new(survey: @survey, user: current_user)
    params[:responses].each do |question_id, answer_id|
      @submission.responses.build :question_id => question_id, :answer_id => answer_id
    end
    if @submission.save
      redirect_to @survey
    else
      debugger
    end
  end

  def edit 
  
  end

  def update
    
  end

end
