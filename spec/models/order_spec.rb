require "rails_helper"

RSpec.describe Order do
  let(:user_1) {FactoryBot.create :user}
  let(:restaurant_1) {FactoryBot.create :restaurant}
  subject {FactoryBot.build :order, user_id: user_1.id}

  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:address).of_type(:string)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:string)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to have_many(:order_details).with_foreign_key(:order_id)}
  end

  describe "#get_total_value_and_get_order_details" do
    let!(:order_1) {FactoryBot.create :order, user_id: user_1.id}
    let!(:food_1) {FactoryBot.create :food, restaurant_id: restaurant_1.id}
    let!(:food_2) {FactoryBot.create :food, restaurant_id: restaurant_1.id}
    let!(:order_detail_1) {FactoryBot.create :order_detail, food_id: food_1.id, order_id: order_1.id}
    let!(:order_detail_2) {FactoryBot.create :order_detail, food_id: food_2.id, order_id: order_1.id, quantity: 10, price: 25000}
    it {expect(order_1.get_total_value).to eql(394000)}
    it {expect(order_1.get_order_details).to eq([order_detail_1, order_detail_2])}
  end
end
