require 'factory_girl'

FactoryGirl.define do 
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    email { "#{username}@test.com" }
    password 'password'
    password_confirmation { password }
    authentication_token SecureRandom.hex
  end

  factory :strain do
    sequence(:name) { |n| "strain_#{n}" }
  end

  factory :plant do
    strain
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
