require "rails_helper"

RSpec.describe OrderDetail do
  let(:user_1) {FactoryBot.create :user}
  let(:restaurant_1) {FactoryBot.create :restaurant}
  let(:food_1) {FactoryBot.create :food, restaurant_id: restaurant_1.id}
  let(:order_1) {FactoryBot.create :order, user_id: user_1.id}

  subject {FactoryBot.build :order_detail, food_id: food_1.id, order_id: order_1.id}
  it {is_expected.to be_valid}RY

  context "columns" do
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:quantity).of_type(:integer)}
    it {is_expected.to have_db_column(:order_id).of_type(:integer)}
    it {is_expected.to have_db_column(:food_id).of_type(:integer)}
  end

  context "quantity" do
    it {expect(subject.quantity).to be_between(Settings.minimum_quantity, Settings.maximum_quantity)}
  end

  context "associations" do
    it {is_expected.to belong_to(:order)}
    it {is_expected.to belong_to(:food)}
  end

  describe "#update_quantity" do
    let!(:order_detail_1) {FactoryBot.create :order_detail, food_id: food_1.id, order_id: order_1.id}
    it {
      order_detail_1.update_quantity(2)
      expect(order_detail_1.quantity).to eql(2)
    }
  end

end
