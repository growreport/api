class Plant < ActiveRecord::Base

  has_many :notes
  has_many :measurements

  belongs_to :group
  belongs_to :strain
  belongs_to :technique
  belongs_to :user
  belongs_to :group

  validates_presence_of :harvest_date
  validates_presence_of :cure_date
  validates_presence_of :age
end
