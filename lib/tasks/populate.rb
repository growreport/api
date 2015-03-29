namespace :db do
  namespace :populate do
    require "faker"
    models = ["users"]

    desc "Clear and populate every table"
    task all: :environment do
      models.each do |model|
        Rake::Task["db:populate:#{model}"].execute
      end
    end

    desc "Clear and populate the users table"
    task users: :environment do
      User.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!("users")
      users = []

      count = 0;
      10.times do
        users.push({  username: Faker::Internet.user_name,
          email: "user#{count}@test.com",
          gender: ["male", "female"].sample,
          birthday: Date.new(1991,10,2),
          credits: rand(10..100),
          password: 'password',
          password_confirmation: 'password'})
        count += 1
      end

      User.create!([users])
      puts "Populated users table"
    end
  end
end

# desc "Clear and populate the categories table"
# task categories: :environment do
#   Category.destroy_all
#   ActiveRecord::Base.connection.reset_pk_sequence!("categories")
#   categories = []
#   category_names = ["Self", "Nature", "Food and Drink", "Nightlife"]
#   category_names.each do |name|
#     categories.push({name: name})
#   end

#   Category.create!([categories])
#   puts "Populated categories table"
# end

# desc "Clear and populate the images table"
# task images: :environment do
#   Image.destroy_all
#   ImageView.destroy_all
#   ActiveRecord::Base.connection.reset_pk_sequence!("images")
#   images = []
#   image_views = []

#   100.times do
#     images.push({ token: SecureRandom.urlsafe_base64,
#                   uri: Faker::Internet.url,
#                   views: rand(100..200),
#                   favorites: rand(0...100),
#                   longitude: Faker::Address.longitude,
#                   latitude: Faker::Address.latitude,
#                   text: Faker::Lorem.characters(30),
#                   category_id: rand(1..Category.count),
#                   creator_id: rand(1..User.count)})
#   end

#   Image.create!([images])
#   puts "Populated images table"
# end

# desc "Clear and populate the flags table"
# task flags: :environment do
#   Flag.destroy_all
#   ActiveRecord::Base.connection.reset_pk_sequence!("flags")
#   flags = []

#   100.times do
#     flags.push({  reason: Flag.reasons.sample,
#                   image_id: rand(1..Image.count),
#                   user_id: rand(1..User.count)})
#   end

#   Flag.create!([flags])
#   puts "Populated flags table"
# end
