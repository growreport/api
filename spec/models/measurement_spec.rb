require "rails_helper"

describe Measurement do
  describe "validations" do
    it { should validate_presence_of :type }
    it { should validate_presence_of :unit }
    it { should validate_presence_of :data }
  end

  describe "associations" do
    it { should belong_to :plant }
  end
end
