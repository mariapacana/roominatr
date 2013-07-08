class User < ActiveRecord::Base
  has_many :submissions
  has_many :responses, through: :submissions
  has_many :answers, through: :responses
	has_many :category_scores
  validates :username, :presence => true,
											 :uniqueness => true
	validates :email, :presence => true,
										:uniqueness => true,
										:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  after_create :create_category_scores
  attr_accessible :username, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :avatar, 
                  :birthday, 
                  :gender, 
                  :food_preferences,
                  :summary,
                  :best_roommate,
                  :worst_roommate,
                  :pets,
                  :weekend_activity

  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "50x50#" }, :default_url => '/default_pic'
  def new_survey
    taken_surveys = submissions.collect {|submission| submission.survey }
    (Survey.all - taken_surveys).sample
  end

  def create_category_scores
    Category.all.each do |category|
      category_score = CategoryScore.new
      category_score.user = self
      category_score.category = category
      category_score.save
    end
  end

  def score(category, type)
    user_answers = answers.select do |a|
      a.question.survey.category == category and
      a.question.qtype == type
    end
    user_answers.inject(0){ |sum, answer| sum + answer.weight }/user_answers.length.to_f
  end

  def compatibility_with(user)
    subs = []
    Category.all.each do |category|
      self_diff = (user.score(category, "roommate") - score(category, "me")).abs
      user_diff = (user.score(category, "me") - score(category, "roommate")).abs
      self_imp = score(category, "importance")
      user_imp = user.score(category, "importance")
      sub = (user_imp*(1-self_diff/2)+self_imp*(1-user_diff/2))/(self_imp+user_imp)
      subs << sub unless sub.nan?
    end
    compat = subs.inject(:+)/subs.length
    (100*compat).floor
  end

  def self.filter_by_age(age_min, age_max)
    age_min = age_min.to_i
    if age_max == ""
      age_max = 200
    else
      age_max = age_max.to_i
    end
    p "age_min #{age_min}"
    p "age_max #{age_max}"
    later = age_min.years.ago
    earlier = age_max.years.ago
    where(birthday: (earlier..later))
  end


  def survey_progress
    submitted = submissions.length
    total = Survey.all.length
    (100*submitted/total.to_f).floor
  end

  def no_surveys?
    submissions.length == 0
  end

end
