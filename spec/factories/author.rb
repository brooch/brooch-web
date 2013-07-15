FactoryGirl.define do
  factory :author do |f|
    sequence(:name) { |n| "name{n}" }
  end
end
