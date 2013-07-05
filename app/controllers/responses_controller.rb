class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end

  def create
    @survey = Survey.find params[:survey_id]
    # @answers = Answer.find params[:choices].values
    params[:responses].each do |question_id, answer_id|

      @survey.responses.build :user => current_user, :question_id => question_id, :answer_id => answer_id
    end
    if @survey.save
      redirect_to root_path
    else
    end
  end

  def edit 
  
  end

  def update
    
  end

end
