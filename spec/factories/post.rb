FactoryGirl.define do
  factory :post do |f|
    sequence(:text) { |n| "text #{n}" }
  end
end







