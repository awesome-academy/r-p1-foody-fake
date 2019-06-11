require "rails_helper"

RSpec.describe Food do
  let(:restaurant_1) {FactoryBot.create :restaurant}
  let(:user_1) {FactoryBot.create :user}
  subject {FactoryBot.build :rating, restaurant_id: restaurant_1.id, user_id: user_1.id}
  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:space_point).of_type(:float)}
    it {is_expected.to have_db_column(:location_point).of_type(:float)}
    it {is_expected.to have_db_column(:service_point).of_type(:float)}
    it {is_expected.to have_db_column(:price_point).of_type(:float)}
    it {is_expected.to have_db_column(:quality_point).of_type(:float)}
    it {is_expected.to have_db_column(:restaurant_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:restaurant)}
  end

  describe "#average_point" do
    let!(:rating_1) {FactoryBot.create :rating, restaurant_id: restaurant_1.id, user_id: user_1.id}
    it {expect(rating_1.average_point).to eql(5.0)}
  end
end
