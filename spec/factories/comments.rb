FactoryGirl.define do
  pw = RandomData.random_sentence
# #3
  factory :comment do
    name RandomData.random_name
# #4
    sequence(:email){|n| "comment#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
  end
end
