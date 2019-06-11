FactoryBot.define do
  factory :food do
    name {FFaker::Food.meat}
    price {12000}
  end
end
