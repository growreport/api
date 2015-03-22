require "rails_helper"

RSpec.describe Post do
  describe "validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :title }
  end

  describe "associations" do
    it { should have_many :comments }
    it { should belong_to :user }
  end
end
