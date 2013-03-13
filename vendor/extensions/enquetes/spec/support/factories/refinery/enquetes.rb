
FactoryGirl.define do
  factory :enquete, :class => Refinery::Enquetes::Enquete do
    sequence(:code_bnpv) { |n| "refinery#{n}" }
  end
end

