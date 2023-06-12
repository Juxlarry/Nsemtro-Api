require 'rails_helper'

RSpec.describe Blog, type: :model do
  it {should belong_to(:category) }

  it {should validate_presence_of(:title) }
  it {should validate_presence_of(:content) }
  it {should validate_presence_of(:author) }

  it { should validate_length_of(:title).is_at_least(3) }
  it { should validate_length_of(:author).is_at_least(2) }

end
