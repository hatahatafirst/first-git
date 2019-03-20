class LikedPost < ApplicationRecord
  belongs_to :user
  belongs_to :hatapost
  
  has_many :liked_posts
  has_many :hataposts
end
