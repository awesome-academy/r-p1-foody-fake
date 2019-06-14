FactoryBot.define do
  factory :comment do
    content {FFaker::Music.album}
  end
end
