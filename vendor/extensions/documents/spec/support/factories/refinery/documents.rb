
FactoryGirl.define do
  factory :document, :class => Refinery::Documents::Document do
    sequence(:titre) { |n| "refinery#{n}" }
  end
end

