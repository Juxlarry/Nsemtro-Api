class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :username, :signature

  attribute :created_date do |user| 
    user.created_at && user.created_at.strftime('%I:%M %p | %m/%d/%Y')
  end 
end
