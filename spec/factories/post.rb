FactoryGirl.define do
  factory :post do |f|
    sequence(:text)     { |n| "text #{n}" }
    image_id Kernel.rand(5)
  end
end
