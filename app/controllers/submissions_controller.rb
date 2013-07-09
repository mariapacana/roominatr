class SubmissionsController < ApplicationController

  include AjaxHelper
  include ScoreHelper

  def new
    p "WE ARE HERE=================================================="
    @submission = Submission.new
    @survey = current_user.new_survey

    render_partial('submission_form', 'new', {:survey => @survey})
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @submission = Submission.new(survey: @survey, user: current_user)
    p current_user
    p @survey.category
    if params[:responses].length != @survey.questions.length
      flash[:error] = "Please fill out all questions!"
      render_partial('submission_form', 'new', {:survey => @survey})
    else
      update_category_score(current_user, @survey.category)      
      # ScoreWorker.perform_async(current_user, @survey.category)
      params[:responses].each do |question_id, answer_id|
        @question = Question.find(question_id.to_i)
        @answer = Answer.find(answer_id.to_i)
        @submission.responses.build(:question_id => question_id,
                                    :answer_id => answer_id,
                                    :submission_id => @submission.id)
      end
      @submission.save
      render_partial('new_submission', 'show', {:submission => @submission})
    end
  end

  def edit
    @submission = Submission.find(params[:id])
    @survey = @submission.survey
    render_partial('submission_form', 'edit', {:survey => @survey})
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @submission = Submission.find(params[:id])

    if params[:responses].length != @survey.questions.length
      flash[:error] = "Please fill out all questions!"
      render_partial('submission_form', 'edit', {:survey => @survey})
    else
      params[:responses].each do |question_id, answer_id|
        @submission.responses.find_by_question_id(question_id).update_attribute('answer_id', answer_id)
      end

      @submission.save

      render_partial('updated_submission', 'show', {:submission => @submission})
    end
  end

  def destroy
    p params
    @submission = Submission.find(params[:id])
    p "DESTROY=============================="
    p @submission
    @submission.destroy
    head :ok
  end

end
