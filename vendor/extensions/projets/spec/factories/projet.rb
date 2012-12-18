FactoryGirl.define do
  factory :projet, :class => Refinery::Projets::Projet do
    name "Refinery"
    email "refinery@cms.com"
    message "Hello..."
  end
end
