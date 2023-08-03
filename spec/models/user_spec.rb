require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(
        name: "John Doe",
        username: "johndoe@example.com",
        email: "sejal@g.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = User.new(username: "johndoe@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a username" do
      user = User.new(name: "John Doe")
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

  end

  describe "associations" do
    it "has many enrollments" do
      association = described_class.reflect_on_association(:enrollments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "has many courses" do
      association = described_class.reflect_on_association(:courses)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "has many lectures" do
      association = described_class.reflect_on_association(:lectures)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "has many messages" do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe "enums" do
    it "defines enum for role with values Instructor and Student" do
      expect(User.roles).to eq({ "Instructor" => 0, "Student" => 1 })
    end
  end


  describe "scopes" do
    it "returns users by role" do
      ActiveRecord::Base.transaction do
        begin
     
          instructors = []
          instructors << User.create!(name: "Instructor Name", username: "instructor@example.com", role: :Instructor, email: "inst@gmail.com", password: "password")
          
          students = []
          students << User.create!(name: "Student Name", username: "student@example.com", role: :Student, email: "stu@gmail.com", password: "password")
          
          # Expectations here
          expect(User.by_role(:Instructor)).to match_array(instructors)
          expect(User.by_role(:Student)).to match_array(students)
          
        ensure
          raise ActiveRecord::Rollback
        end
      end
    end
  end

end
