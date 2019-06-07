require "rails_helper"

RSpec.describe User do
  subject {FactoryBot.build :user}
  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:password_digest).of_type(:string)}
  end

  context "email" do
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_length_of(:email)}
    it {is_expected.to allow_value("nd26041998@gmail.com").for(:email)}
    it {is_expected.not_to allow_value("ccccc").for(:email)}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
  end

  context "name" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_length_of(:name)}
  end

  context "password" do
    it {is_expected.to have_secure_password}
    it {is_expected.to validate_length_of(:password)}
  end

  context "associations" do
    it {is_expected.to have_many(:ratings).with_foreign_key(:user_id)}
    it {is_expected.to have_many(:comments).with_foreign_key(:user_id)}
    it {is_expected.to have_many(:comment_likes).with_foreign_key(:user_id)}
    it {is_expected.to have_many(:orders).with_foreign_key(:user_id)}
  end

  describe ".new_token" do
    let(:token_1) {User.new_token}
    let(:token_2) {User.new_token}

    it {expect(token_1).not_to eq(token_2)}
  end

  describe "#downcase_email" do
    it{
      subject.email = "Nd26041998@GMAiL.com"
      expect {subject.save}.to change(subject, :email).from("Nd26041998@GMAiL.com")
        .to("nd26041998@gmail.com")
    }
  end

  describe "#remember" do
    it {expect {subject.remember}.to change(subject, :remember_digest).from(nil).to(String)}
  end

  describe "#get_restaurant" do
    let!(:user_1) {FactoryBot.create :user, type_of_user: "manager"}
    let!(:restaurant_1) {FactoryBot.create :restaurant, manager_id: user_1.id}
    it {expect(user_1.get_restaurant).to eq(restaurant_1)}
  end

  describe "#checktype" do
    let!(:user_1) {FactoryBot.create :user, type_of_user: "manager"}
    it {expect(user_1.check_type("manager")).to eq(true)}
  end
end
