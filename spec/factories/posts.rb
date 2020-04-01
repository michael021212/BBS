FactoryBot.define do
  factory :post do
    user
    nickname { 'user' }
    title { 'title' }
  end

  trait :no_title do
    title {}
  end

  trait :too_long_title do
    title { 'a' * 31 }
  end

  trait :no_nickname do
    nickname {}
  end

  trait :too_long_nickname do
    nickname { 'a' * 11 }
  end
end
