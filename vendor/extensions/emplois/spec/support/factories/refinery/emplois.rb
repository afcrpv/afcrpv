
FactoryGirl.define do
  factory :emploi, :class => Refinery::Emplois::Emploi do
    sequence(:organisation) { |n| "refinery#{n}" }
  end
end

