require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "full_name" do
    it "joins first_name and last_name together with a space" do
      user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")

      expect(user.full_name).to eq("John Doe")
    end

    it "trims dangling spaces at the beginning and at the end" do
      user = FactoryBot.build(:user, first_name: "John", last_name: nil)

      expect(user.full_name).to eq("John")

      user = FactoryBot.build(:user, first_name: nil, last_name: "Doe")

      expect(user.full_name).to eq("Doe")
    end
  end

  describe "validates" do
    it "requires unique emails" do
      persisted_user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, email: persisted_user.email)

      user.valid?

      expect(user.errors.messages).to have_key(:email)
    end
    
    [
      "what",
      "$()@whatever.com",
      "bob@google.123",
      "test@test$com",
      "name@domain.c-m",
      "🔥@email.ca",
      "@end.com"      
    ].each do |invalid_email|  
      it "requires email \"#{invalid_email}\" formatted correctly" do
        user = FactoryBot.build(:user)

        user.email = invalid_email

        user.valid?

        expect(user.errors.messages).to(have_key(:email), "expected \"#{invalid_email}\ to be invalid")

      end
    end
  end
end
