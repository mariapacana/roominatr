class User < ActiveRecord::Base
  has_many :submissions
  has_many :responses, through: :submissions
  has_many :answers, through: :responses
	validates :username, :presence => true, 
											 :uniqueness => true
	validates :email, :presence => true,
										:uniqueness => true,
										:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  attr_accessible :username, :email, :password, :password_confirmation, :avatar, :birthday, :gender
  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def new_survey
    taken_surveys = submissions.collect {|submission| submission.survey }
    (Survey.all - taken_surveys).sample
  end

  def score(category_name, type)
    answered = 0
    score = 0 
    submissions.each do |sub|
      if sub.survey.category.name == category_name
        sub.responses.each do |resp|
          if resp.answer.question.qtype == type
            score += resp.answer.weight
            answered += 1
          end
        end
      end
    end
    score/answered.to_f
  end
end
