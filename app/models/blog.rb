class Blog < ApplicationRecord
  belongs_to :category

  validates :title, presence: true, length: {minimum:3}
  validates :author, presence: true, length: {minimum:2}
  validates :content, presence: true 
end
