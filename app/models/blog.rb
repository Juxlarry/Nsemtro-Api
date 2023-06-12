class Blog < ApplicationRecord
  belongs_to :category

  validates :title,:author, presence: true, length: {minimum:3}
  validates :content, presence: true
end
