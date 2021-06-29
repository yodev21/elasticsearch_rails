FactoryBot.define do
  factory :publisher do
    sequence(:name) { |n| "TEST#{n}出版" }
  end
end