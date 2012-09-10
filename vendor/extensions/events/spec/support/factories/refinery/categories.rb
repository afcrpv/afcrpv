
FactoryGirl.define do
  factory :category, :class => Refinery::Categories::Category do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

