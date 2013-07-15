FactoryGirl.define do
  factory :tag do |f|
    sequence(:name) { |n| "tag#{n}" }
  end
end
