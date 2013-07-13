FactoryGirl.define do
  factory :user do |f|
    sequence(:name)  { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    api_token        Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)

    password              'password'
    password_confirmation 'password'
  end
end
