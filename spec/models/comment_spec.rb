require "rails_helper"

RSpec.describe Comment do
  let(:restaurant_1) {FactoryBot.create :restaurant}
  let(:user_1) {FactoryBot.create :user}
  subject {FactoryBot.build :comment, restaurant_id: restaurant_1.id, user_id: user_1.id}

  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:content).of_type(:string)}
    it {is_expected.to have_db_column(:restaurant_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "content" do
    it {is_expected.to validate_presence_of(:content)}
    it {is_expected.to validate_length_of(:content)}
  end

  context "associations" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:restaurant)}
    it {is_expected.to have_many(:comment_likes).with_foreign_key(:comment_id)}
  end

  context "scope" do
    let!(:comment_1) {FactoryBot.create :comment, restaurant_id: restaurant_1.id, user_id: user_1.id, created_at: "2019-06-07 01:41:41"}
    let!(:comment_2) {FactoryBot.create :comment, restaurant_id: restaurant_1.id, user_id: user_1.id, created_at: "2019-06-07 01:41:45"}
    let!(:comment_3) {FactoryBot.create :comment, restaurant_id: restaurant_1.id, user_id: user_1.id, created_at: "2019-06-07 01:41:49"}

    it {expect(Comment.ordered_by_created_at).to eq([comment_3, comment_2, comment_1])}
  end
end
