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
    user_answers = answers.select do |a|
      a.question.survey.category.name == category_name and
      a.question.qtype == type
    end
    user_answers.inject(0){ |sum, answer| sum + answer.weight }/user_answers.length.to_f  
  end

  def compatibility_with(user)
    subs = []
    Category.all.each do |category|
      name = category.name
      self_diff = (user.score(name, "roommate") - self.score(name, "me")).abs
      user_diff = (user.score(name, "me") - self.score(name, "roommate")).abs
      self_imp = self.score(name, "importance")
      user_imp = user.score(name, "importance")
      sub = (user_imp*(1-self_diff/2)+self_imp*(1-user_diff/2))/(self_imp+user_imp)
      subs << sub unless sub.nan?
    end
    subs.inject(:+)/subs.length
  end

end
