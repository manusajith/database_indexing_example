require 'factory_girl'

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :first_name do |n|
    "user#{n}"
  end

  sequence :second_name do |n|
    "last_name#{n}"
  end

end

FactoryGirl.define do
  factory :user do
    email
    first_name
    second_name
    password "password"
    password_confirmation "password"
    status true
  end
end

namespace :user do
  desc "Add a admin user."
  task :create => :environment do
    FactoryGirl.create_list(:user, 10000)
  end
end