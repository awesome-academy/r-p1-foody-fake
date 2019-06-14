FactoryBot.define do
  factory :order do
    address {FFaker::Address.street_address}
    name {FFaker::Internet.user_name}
    status {"pending"}
  end
end
