class Measurement < ActiveRecord::Base
  belongs_to :plant

  validates_presence_of :type

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
