class User < ActiveRecord::Base
  has_many :responses
  has_many :answers, through: :responses
	validates :username, :presence => true, 
											 :uniqueness => true
	validates :email, :presence => true,
										:uniqueness => true,
										:format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, :presence => true,
  										 :length => {:minimum => 1}
  attr_accessible :username, :email, :password, :password_confirmation, :avatar, :birthday, :gender
  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
