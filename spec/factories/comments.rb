FactoryBot.define do
  factory :comment do
    user_id { '1' }
    post
    nickname { 'user' }
    body { 'body' }
  end

  trait :no_body do
    body {}
  end

  trait :too_long_body do
    body { 'a' * 201 }
  end

  trait :no_nickname_comment do
    nickname {}
  end

  trait :too_long_nickname_comment do
    nickname { 'a' * 11 }
  end
end
