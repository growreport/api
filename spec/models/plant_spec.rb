require "rails_helper"

describe Plant do
  describe "validations" do
    it { should validate_presence_of :age }
    it { should validate_presence_of :harvest_date }
    it { should validate_presence_of :cure_date }
  end

  describe "associations" do
    it { should belong_to :strain }
    it { should belong_to :user }
    it { should belong_to :group }
    it { should have_many :measurements }
  end
end
