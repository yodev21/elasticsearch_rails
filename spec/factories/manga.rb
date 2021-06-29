FactoryBot.define do
  factory :manga do
    association :category, factory: :category
    association :author, factory: :author
    association :publisher, factory: :publisher
    sequence(:title) { |n| "TEST_PRODUCT#{n}" }
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }
  end
end