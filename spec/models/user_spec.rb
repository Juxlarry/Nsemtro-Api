require 'rails_helper'

RSpec.describe User, type: :model do
  subject{ build(:user)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should validate_uniqueness_of(:username).ignoring_case_sensitivity }
  it {should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it {should validate_length_of(:username).is_at_least(3) }

  it {should_not validate_length_of(:password).is_at_least(5) }

  describe 'Associations' do 
    it {should have_many(:blogs) }
  end 
end