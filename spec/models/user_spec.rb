require "rails_helper"

describe User do
  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
  end

  describe "uniqueness validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  describe "associations" do
    it { should have_many :plants }
    it { should have_many :posts }
    it { should have_many :comments }
  end
end
