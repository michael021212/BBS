FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'password' }
  end

  trait :no_name do
    name {}
  end

  trait :too_long_name do
    name { 'a' * 21 }
  end
end
