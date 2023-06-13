FactoryBot.define do 
    factory :user do 
        name {Faker::Name.unique.name}
        sequence(:username) { |n| "U#{n}#{Faker::Internet.username(specifier: 5..10)}" }
        # username {Faker::Internet.username(specifier: 5..10)}
        sequence(:email) { |n| "test#{n}@example.com" }
        password { "password" }
    end
end
