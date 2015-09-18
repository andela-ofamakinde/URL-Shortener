require 'rails_helper'

RSpec.describe User, type: :model do
  describe "create user" do
    it "should create a new user" do
      user1 = User.create(name: 'Seyi', email: 'seyi@gmail.com', password: "seyioluwa")
      user2 = User.create(name: 'Jeff', email: 'jeff@gmail.com', password: "jeffwan")

      expect(user1).to be_valid

      expect(user2).to be_valid
    end

    it "should not create user with invalid email format" do
      user3 = User.create(name: 'Dais', email: 'daisigmail.com', password: "oluwadaisi")
      user4= User.create(name: 'cent', email: 'cent@gmail', password: "seyioluwa")

      expect(user3).not_to be_valid
      expect(user4).not_to be_valid
    end

    it "should not create user with a missing property" do
      user5 = User.create(name: 'Dais', email: 'daisigmail.com')
      user6 = User.create(name: 'cent', password: "seyioluwa")

      expect(user5).not_to be_valid
      expect(user6).not_to be_valid
    end
  end
end
