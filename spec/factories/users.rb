FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_user#{n}@cfa.org" }
  end
end
