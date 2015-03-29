class Note < ActiveRecord::Base
  belongs_to :plant

  validates_presence_of :content
end
