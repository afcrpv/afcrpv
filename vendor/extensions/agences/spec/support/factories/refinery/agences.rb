
FactoryGirl.define do
  factory :agence, :class => Refinery::Agences::Agence do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

