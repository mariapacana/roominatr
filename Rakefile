#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'csv'

Roominatr::Application.load_tasks

namespace :db do
  desc "Seeding surveys"
  task :survey_seed => :environment do
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
end
