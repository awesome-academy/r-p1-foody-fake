FactoryBot.define do
  factory :restaurant do
    name {FFaker::Company.name}
    location {FFaker::Address.street_address}
    open_time {36000}
    close_time {72000}
  end
end
