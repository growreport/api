class Measurement < ActiveRecord::Base
  belongs_to :plant

  validates_presence_of :type
  validates_presence_of :unit
  validates_presence_of :data

  def self.types
    [
      'tds', 'ambient temperature', 'humidity'
    ]
  end

  def self.units
    [
      'ppm', 'celsius', 'farenheit', 'EC'
    ]
  end
end
