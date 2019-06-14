require "rails_helper"

RSpec.describe Food do
  let(:restaurant_1) {FactoryBot.create :restaurant}
  subject {FactoryBot.build :food, restaurant_id: restaurant_1.id}
  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:restaurant_id).of_type(:integer)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_length_of(:name)}
    it {is_expected.to validate_presence_of(:price)}
  end

  context "associations" do
    it {is_expected.to have_many(:order_details).with_foreign_key(:food_id)}
    it {is_expected.to belong_to(:restaurant)}
  end
end
