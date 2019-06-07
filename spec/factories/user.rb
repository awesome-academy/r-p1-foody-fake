FactoryBot.define do
  factory :user do
    name {FFaker::Internet.user_name}
    email {FFaker::Internet.free_email}
    password {"something"}
    password_confirmation {"something"}
  end
end
