FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "Mahalo43"
    password_confirmation "Mahalo43"
    is_editor true
    is_writer true
    is_admin false
  end
end