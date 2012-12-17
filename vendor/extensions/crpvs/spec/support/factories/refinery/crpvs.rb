
FactoryGirl.define do
  factory :crpv, :class => Refinery::Crpvs::Crpv do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

