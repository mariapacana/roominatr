class SubmissionsController < ApplicationController

  def new
    @submission = Submission.new
    @survey = current_user.new_survey

    render :json => { :submission_form => render_to_string(:partial => 'new',
                                                           :locals => {:survey => @survey },
                                                           :layout => false)}
  end

  def create
    @survey = Survey.find params[:survey_id]
    @submission = Submission.new(survey: @survey, user: current_user)

    if params[:responses].length != @survey.questions.length
      flash[:error] = "Please fill out all questions!"
      render :json => { :submission_form => render_to_string(:partial => 'new',
                                                             :locals => {:survey => @survey },
                                                             :layout => false)}
    else
      params[:responses].each do |question_id, answer_id|
        @submission.responses.build(:question_id => question_id,
                                    :answer_id => answer_id,
                                    :submission_id => @submission.id)
      end

      @submission.save
      render :json => { :new_submission => render_to_string(:partial => 'show',
                                                            :locals => {:submission => @submission },
                                                            :layout => false)}
    end
  end

  def edit

  end

  def update

  end

end
