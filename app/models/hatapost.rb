class Hatapost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :liked_posts
end
