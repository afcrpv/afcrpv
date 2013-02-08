
FactoryGirl.define do
  factory :news_category, :class => Refinery::NewsCategories::NewsCategory do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

