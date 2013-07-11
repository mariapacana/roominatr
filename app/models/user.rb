class User < ActiveRecord::Base
  has_many :submissions
  has_many :responses, through: :submissions
  has_many :answers, through: :responses
	has_many :category_scores
  has_one :house
  has_one :location, :as => :addressable

  validates :username, :presence => true,
											 :uniqueness => true
	validates :email, :presence => true,
										:uniqueness => true,
										:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates_presence_of :birthday, :gender, :location
  validates_inclusion_of :has_house, :in => [true, false]
  validates_length_of :summary, :maximum => 200, :message =>"should be less than 200 characters"
  validates :rent_pref_min, :numericality => { :greater_than => 0, :less_than_or_equal_to => :rent_pref_max }, :allow_nil => true
  validates :rent_pref_max, :numericality => { :greater_than => 0 }, :allow_nil => true
  validates_associated :house
  validates_associated :location
                    
  after_create :create_category_scores

  accepts_nested_attributes_for :location

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
                  :weekend_activity,
                  :location,
                  :location_attributes,
                  :has_house,
                  :rent_pref_min,
                  :rent_pref_max,
                  :admin

  has_secure_password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }, :default_url => '/default_image'

  scope :younger_than, lambda { |age| where('birthday > ?', age.to_i.years.ago) }
  scope :older_than, lambda { |age| where('birthday < ?', age.to_i.years.ago) }
  scope :cheaper_than, lambda { |max_rent| joins(:house).where('rent < ?', max_rent) }
  scope :more_expensive_than, lambda { |min_rent| joins(:house).where('rent > ?', min_rent) }
  scope :neighborhood, lambda { |hood| includes(:house => :location).where('locations.neighborhood like ?', "%#{hood}%")}
  scope :city, lambda { |city| includes(:house => :location).where('locations.city like ?', "%#{city}%")}

  def new_survey
    taken_surveys = submissions.collect {|submission| submission.survey }
    (Survey.all - taken_surveys).sample
  end

  def age
    ((DateTime.now.to_date - birthday)/365.25).floor
  end

  def create_category_scores
    Category.all.each do |category|
      category_score = CategoryScore.new
      category_score.user = self
      category_score.category = category
      category_score.save
    end
  end

  def score_slow(category, type)
    user_answers = answers.select do |a|
      a.question.survey.category == category and
      a.question.qtype == type
    end
    user_answers.inject(0){ |sum, answer| sum + answer.weight }/user_answers.length.to_f
  end

  def score(category, type)
    qtype = type.to_sym
    category_score = category_scores.where(category_id: category.id).first
    category_score.read_attribute(qtype)
  end

  def compatibility_with(user)
    subs = []
    Category.all.each do |category|
      self_diff = (user.score(category, "roommate") - score(category, "me")).abs.to_f
      user_diff = (user.score(category, "me") - score(category, "roommate")).abs.to_f
      self_imp = score(category, "importance")
      user_imp = user.score(category, "importance")
      sub = (user_imp*(1-self_diff/2)+self_imp*(1-user_diff/2))/(self_imp+user_imp)
      subs << sub unless sub.nan?
    end
    return 0 if subs.empty?
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
    birthday && ((DateTime.now.to_date - birthday)/365.25).to_i
  end

  def survey_progress
    submitted = submissions.length
    return 0.0 if submitted == 0
    total = Survey.all.length
    (100*submitted/total.to_f).floor
  end

  def no_surveys?
    submissions.length == 0
  end

  def category_score(category, qtype)
    category_score = category_scores.where(category_id: category.id).first
    category_score.read_attribute(qtype)
  end

  def top_users(page, offset = 20)
    compat_limit = 80
    users = {}
    user_pool = User.all[page*offset..(page+1)*offset-1]    
    user_pool.each do |user|
      compat = user.compatibility_with(self)
      users[user] = compat if compat > compat_limit
    end
    users
  end

end
