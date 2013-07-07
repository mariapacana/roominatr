class SubmissionsController < ApplicationController

  include AjaxHelper

  def new
    @submission = Submission.new
    @survey = current_user.new_survey

    render_partial('submission_form', 'new', {:survey => @survey})
  end

  def create
    @survey = Survey.find params[:survey_id]
    @submission = Submission.new(survey: @survey, user: current_user)

    if params[:responses].length != @survey.questions.length
      flash[:error] = "Please fill out all questions!"
      render_partial('submission_form', 'new', {:survey => @survey})
    else
      params[:responses].each do |question_id, answer_id|
        @submission.responses.build(:question_id => question_id,
                                    :answer_id => answer_id,
                                    :submission_id => @submission.id)
      end

      @submission.save

      render_partial('new_submission', 'show', {:submission => @submission})
    end
  end

  def edit

  end

  def update

  end

end
