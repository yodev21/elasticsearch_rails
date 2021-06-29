FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "TEST#{n}太郎" }
  end
end