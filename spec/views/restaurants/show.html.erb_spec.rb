require "rails_helper"
require "spec_helper"

describe "restaurants/show.html.erb" do
  let!(:restaurant) { FactoryBot.create :restaurant }
  let!(:user) { FactoryBot.create :user }
  let!(:rating) { FactoryBot.create :rating, restaurant_id: restaurant.id, user_id: user.id }
  let!(:comment) { FactoryBot.create :comment, restaurant_id: restaurant.id, user_id: user.id }
  let!(:comment_1) { FactoryBot.create :comment, restaurant_id: restaurant.id, user_id: user.id }
  let!(:food) { FactoryBot.create :food, restaurant_id: restaurant.id }

  before {
    assign(:restaurant, restaurant)
    assign(:restaurant, restaurant)
    assign(:rating, rating)
  }

  it "displays restaurants details correctly" do
    render
    expect(rendered).to have_content restaurant.name
    expect(rendered).to have_content restaurant.location
    expect(rendered).to have_content "10:00AM"
    expect(rendered).to have_content "08:00PM"
  end

  it "displays number of ratings correctly" do
    render
    expect(rendered).to have_content "1"
  end

  it "displays number of comments correctly" do
    render
    expect(rendered).to have_content "2"
  end
end
