Factory.define do 
    factory :user do 
        name {Faker::Name.unique.name}
        username {Faker::Internet.username(specifier: 5..10)}
        sequence(:email) { |n| "test#{n}@example.com" }
        password { "password" }
end
