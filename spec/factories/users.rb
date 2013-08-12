# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'typicaluserpassword'
    password_confirmation 'typicaluserpassword'
  end

  factory :admin_user, class: User do
    email 'admin@example.com'
    password 'likeaboss'
    password_confirmation 'likeaboss'
    admin true
  end
end
