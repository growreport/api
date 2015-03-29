require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    email { "#{username}@test.com" }
    password 'password'
    password_confirmation { password }
    auth_token SecureRandom.hex
  end

  factory :plant do
    age 40
    harvest_date Time.now
    cure_date Time.now + 6.days
  end

  factory :post do
    sequence(:title) { |n| "post_#{n}" }
    content 'content'
    user
  end

  factory :comment do
    content 'content'
    post
    user
  end
end
