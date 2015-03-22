class User < ActiveRecord::Base
  has_secure_password

  has_many :plants
  has_many :posts
  has_many :comments

  validates :email, :username,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates(:email, format: /\A.+@.+\Z/)
end
