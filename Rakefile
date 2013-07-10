#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'csv'
require "#{Rails.root}/app/helpers/application_helper"
require "#{Rails.root}/lib/score_helper"
include ApplicationHelper
include ScoreHelper

Roominatr::Application.load_tasks

namespace :db do 
  task :dcm => [:drop, :create, :migrate, :seed_all] do
    puts "dropped, created, migrated and seeded"
  end
end

namespace :db do
  task :seed_all => [:category_seed, :survey_seed, :user_seed, :submission_seed, :score_seed, :house_seed] do
    puts "Seeded everything!"
  end

  desc "Seeding categories..."
  task :category_seed => :environment do
    puts "Creating categories -- these ALWAYS have to be hardwired in"

    Category.destroy_all
    CATEGORIES = %w[Cleanliness Responsibility Sociability]
    CATEGORIES.each { |cat| Category.find_or_create_by_name(cat)}

  end

  desc "Seeding surveys"
  task :survey_seed => :environment do
    puts "Seeding surveys..."

    Survey.destroy_all
    csv_text = File.read('db/surveydata.csv')
    csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
    csv.each do |row|
      data = row.to_hash
      category = Category.find_by_name(data[:category])

      attributes = {title: data[:title],
                    category: category,
                    questions_attributes: {"0" => { body: data[:question],
                                                  answers_attributes: {"0" => {text: data[:answer1],
                                                                            weight: -1},
                                                                       "1" => {text: data[:answer2],
                                                                           weight: 0 },
                                                                       "2"=> {text: data[:answer3],
                                                                            weight: -1}
                                                                      }
                                                }
                                           }
                   }
      Survey.create(attributes)
    end

  end

  desc "Seeding users"
  task :user_seed => :environment do
    puts "Seeding users..."
    User.destroy_all
    CategoryScore.destroy_all

    ZIP_CODES = %w(94108 94109 94110 94111 94114 94115 94116 94117 94118)

    User.create(username: 'maria', email: 'maria@bear.com', password: 'bear', gender: 'F', birthday: '1982-10-30', has_house: true, location:  Location.create(zip: ZIP_CODES.sample), admin: true)
    User.create(username: 'will', email: 'will@bear.com', password: 'bear', gender: 'M', birthday: '1982-10-30', has_house: true, location:  Location.create(zip: ZIP_CODES.sample),admin: true)
    User.create(username: 'quaria', email: 'quaria@bear.com', password: 'bear', gender: 'F', birthday: '1982-10-30', has_house: false, location:  Location.create(zip: ZIP_CODES.sample),admin: true)

    100.times do
      User.create(username: Faker::Internet.user_name,
                  email: Faker::Internet.email,
                  password: "password",
                  gender: ["M", "F"].sample,
                  birthday: random_birthday,
                  has_house: [true,false].sample,
                  location: Location.create(zip: ZIP_CODES.sample))
    end

  end

  desc "Seeding submissions"
  task :submission_seed => :environment do
    puts "Seeding submissions..."
    MAX_SURVEYS = Survey.count
    MIN_SURVEYS = Survey.count/3

    Submission.destroy_all
    users = User.all

    users.each do |user|
      surveys = Survey.all
      rand(MIN_SURVEYS..MAX_SURVEYS).times do
        survey = surveys.delete_at(rand(0..surveys.size-1))
        submission = Submission.create(survey: survey, user: user)        
        survey.questions.each do |question|
          answer_ids = question.answers.pluck(:id)
          answer_id = answer_ids.sample
          answer = Answer.find(answer_id)
          submission.responses.build(question_id: question.id,
                                     answer_id: answer_id)
        end
        submission.save
      end
    end
  end

  desc "Seeding Category scores"
  task :score_seed => :environment do
    puts "Seeding category scores..."
    CategoryScore.destroy_all
    User.all.each do |user|
      Category.all.each do |category|
        category_score = CategoryScore.create(user: user, category: category)
        update_category_score(user, category)
      end
    end
  end

  desc "Seeding Houses"
  task :house_seed => :environment do
    puts "Seeding Houses..."
    House.destroy_all
    csv_file = File.read('addresses.csv')
    csv = CSV.parse(csv_file)
    addresses = csv.map { |address| address[0].strip }
    users = User.all
    users.shuffle!
    addresses.shuffle!
    50.times do
      location = Location.create(address: addresses.pop, city: 'San Francisco', state: 'CA')
      house = House.create(rent: rand(300..3000), location: location, user: users.pop)
    end
  end
end




