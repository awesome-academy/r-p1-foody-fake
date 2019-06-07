require "rails_helper"

RSpec.describe Restaurant do
  subject {FactoryBot.build :restaurant}
  let(:user_1) {FactoryBot.create :user}
  let(:restaurant_1) {FactoryBot.create :restaurant}

  it {is_expected.to be_valid}

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:location).of_type(:string)}
    it {is_expected.to have_db_column(:open_time).of_type(:integer)}
    it {is_expected.to have_db_column(:close_time).of_type(:integer)}
  end

  context "name" do
    it {is_expected.to validate_presence_of(:name)}
  end

  context "location" do
    it {is_expected.to validate_presence_of(:location)}
  end

  context "open_time" do
    it {is_expected.to validate_presence_of(:open_time)}
  end

  context "close_time" do
    it {is_expected.to validate_presence_of(:close_time)}
  end

  context "associations" do
    it {is_expected.to have_many(:foods).with_foreign_key(:restaurant_id)}
    it {is_expected.to have_many(:ratings).with_foreign_key(:restaurant_id)}
    it {is_expected.to have_many(:comments).with_foreign_key(:restaurant_id)}
  end

  describe ".search" do
    let!(:restaurant_1) {FactoryBot.create :restaurant, name: "Hoàng Đạo Thúy"}
    let!(:restaurant_2) {FactoryBot.create :restaurant, name: "Some thing"}
    let!(:restaurant_3) {FactoryBot.create :restaurant, name: "Hoàng Văn Thụ"}
    let!(:restaurant_4) {FactoryBot.create :restaurant, name: "Some thing 2"}
    it {expect(Restaurant.search("Hoàng")).to eq([restaurant_1, restaurant_3])}
  end

  describe ".search_by_location" do
    let!(:restaurant_1) {FactoryBot.create :restaurant, location: "Ngõ 199 Trần Quốc Hoàn, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Hà Nội"}
    let!(:restaurant_2) {FactoryBot.create :restaurant, location: "Ngõ 299 Trần Quốc Hoàn, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Long An"}
    let!(:restaurant_3) {FactoryBot.create :restaurant, location: "Ngõ 399 Trần Quốc Hoàn, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Hà Nội"}
    let!(:restaurant_4) {FactoryBot.create :restaurant, location: "Ngõ 499 Trần Quốc Hoàn, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Long An"}
    it {expect(Restaurant.search_by_location("Thành phố Hà Nội", "Quận Cầu Giấy", "Phường Mai Dịch")).to eq([restaurant_1, restaurant_3])}
  end

  describe ".search_near_me" do
    let!(:restaurant_1) {FactoryBot.create :restaurant, longitude: 21.12, latitude: 21.12}
    let!(:restaurant_2) {FactoryBot.create :restaurant, longitude: 25.12, latitude: 25.12}
    let!(:restaurant_3) {FactoryBot.create :restaurant, longitude: 29.12, latitude: 29.12}
    let!(:restaurant_4) {FactoryBot.create :restaurant, longitude: 31.12, latitude: 31.12}
    it {expect(Restaurant.search_near_me(25.12, 25.12)).to eq([restaurant_2])}
  end

  describe "#count_comments" do
    let!(:comment_1) {FactoryBot.create :comment, user_id: user_1.id, restaurant_id: restaurant_1.id}
    it {expect(restaurant_1.number_of_commented).to be(1)}
  end

  describe "#count_rating" do
    let!(:rating_1) {FactoryBot.create :rating, user_id: user_1.id, restaurant_id: restaurant_1.id}
    it {expect(restaurant_1.number_of_rated).to be(1)}
  end

  describe "#get_point" do
    let!(:rating_1) {FactoryBot.create :rating, user_id: user_1.id, restaurant_id: restaurant_1.id}
    it {expect(restaurant_1.get_point "space_point").to eql(5.0)}
    it {expect(restaurant_1.get_point "location_point").to eql(5.0)}
  end

  describe "#get_average_point" do
    let!(:rating_1) {FactoryBot.create :rating, user_id: user_1.id, restaurant_id: restaurant_1.id}
    it {expect(restaurant_1.get_average_point ).to eql(5.0)}
  end
end
