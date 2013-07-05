class User < ActiveRecord::Base
  has_many :responses
  has_many :answers, through: :responses
	validates :username, :presence => true, 
											 :uniqueness => true
	validates :email, :presence => true,
										:uniqueness => true,
										:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  attr_accessible :username, :email, :password, :password_confirmation, :avatar, :birthday, :gender
  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def surveys
    responses.pluck(:survey_id).uniq.collect {|survey_id| Survey.find(survey_id)}
  end
end
