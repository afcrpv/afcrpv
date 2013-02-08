
FactoryGirl.define do
  factory :category, :class => Refinery::Documents::Category do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

