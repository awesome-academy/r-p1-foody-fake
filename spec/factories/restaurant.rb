FactoryBot.define do
  factory :restaurant do
    name {FFaker::Company.name}
    location {FFaker::Address.street_address}
    open_time {12000}
    close_time {24000}
  end
end
