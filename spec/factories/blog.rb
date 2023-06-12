FactoryBot.define do 
    factory :blog do 
        title {Faker::Book.title}
        content {Faker::Lorem.paragraph}
        author {Faker::Book.author}
        category {create(:category) }
    end 
end 