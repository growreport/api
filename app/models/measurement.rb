class Measurement < ActiveRecord::Base
  belongs_to :plant

  validates_presence_of :type
end
