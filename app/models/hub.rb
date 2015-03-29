class Hub < ActiveRecord::Base
  belongs_to :user

  has_many :measurements
  has_many :actions
end
