require 'rails_helper'

RSpec.describe User, type: :model do

  let(:valid_attributes){{
    first_name: "Sean",
    last_name: "Kelley",
    email: "s.kelley27@gmail.com",
    password: "securepass1234",
    password_confirmation: "securepass1234"
  }}

  context "relationships" do
    it { should have_many(:todo_lists)}
  end

  context "validations" do 
    let(:user) {User.new(valid_attributes)}

    before do
      User.create(valid_attributes)
    end

    it "requires an email " do 
      expect(user).to validate_presence_of(:email)
    end

    it "requires unique email " do 
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires unique email (case insensitive)" do
      user.email = "S.KELLEY27@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end    

    it "requires the email address to look like an email address" do
      user.email = "Sean" 
      expect(user).to_not be_valid
    end

  end

  context "#downcase_email" do
    it "makes the email attr lowercase" do 
      user = User.new(valid_attributes.merge(email: "S.KELLEY27@GMAIL.COM"))
      #user.downcase_email
      #expect(user.email).to eq("s.kelley27@gmail.com")
      expect{ user.downcase_email }.to change{user.email}.
        from("S.KELLEY27@GMAIL.COM").to("s.kelley27@gmail.com")
    end

    it "downcase email before saving" do
      user = User.new(valid_attributes)
      user.email = "S.KELLEY27@GMAIL.COM"
      expect(user.save).to be true
      expect(user.email).to eq("s.kelley27@gmail.com")
    end
  end

  describe "#generate_password_reset_token!" do
    let(:user){create(:user)}
    it "changes the password_reset_token attribute" do 
      expect{user.generate_password_reset_token!}.to change{user.password_reset_token}
    end 
    it "calls SecureRandom.urlsafe_base64" do 
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end
end
