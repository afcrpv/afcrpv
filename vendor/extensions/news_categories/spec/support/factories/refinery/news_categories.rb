
FactoryGirl.define do
  factory :news_category, :class => Refinery::NewsCategories::NewsCategory do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

