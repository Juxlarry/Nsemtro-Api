class Blog < ApplicationRecord
  # before_save :add_author
  belongs_to :category

  has_many_attached :blog_images

  validates :title, presence: true, length: {minimum:3}
  validates :author, presence: true, length: {minimum:2}
  validates :content, presence: true 

  private 

  # def add_author
  #   logger.info "In the before save method"
  #   if current_user
  #     self.author = current_user.username
  #   end
  # end 
end
