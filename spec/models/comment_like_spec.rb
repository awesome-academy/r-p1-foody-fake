require "rails_helper"

RSpec.describe CommentLike do
  let(:user_1) {FactoryBot.create :user}
  let(:restaurant_1) {FactoryBot.create :restaurant}
  let!(:comment_1) {FactoryBot.create :comment, restaurant_id: restaurant_1.id, user_id: user_1.id}
  subject {FactoryBot.build :comment_like, comment_id: comment_1.id, user_id: user_1.id}

  context "columns" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:comment_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:comment)}
  end
end
