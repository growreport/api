class Group < ActiveRecord::Base
  has_many :plants
  belongs_to :user
end
