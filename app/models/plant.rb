class Plant < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :notes
  has_many :measurements

  validates_presence_of :harvest_date
  validates_presence_of :strain
  validates_presence_of :technique
  validates_presence_of :cure_date
  validates_presence_of :age
end
