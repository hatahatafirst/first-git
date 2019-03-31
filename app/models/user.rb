class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 140 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates :password_confirmation, presence: true
                    
    mount_uploader :image, ImagesUploader
    
    has_secure_password    
    
    has_many :hataposts, dependent: :destroy
    has_many :relationships,  dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship,  dependent: :destroy, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    has_many :likes, through: :liked_posts, source: :hatapost
    has_many :liked_posts, dependent: :destroy

    def follow(other_user)
        unless self ==other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
        end 
    end 
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end 
    
    def following?(other_user)
        self.followings.include?(other_user)
    end 

    def feed_hataposts
        Hatapost.where(user_id: self.following_ids + [self.id])
    end 
    
    def liked(hatapost)
     self.liked_posts.find_or_create_by(hatapost_id: hatapost.id)
    end 
    
    def unliked(hatapost)
        liked_post = self.liked_posts.find_by(hatapost_id: hatapost.id)
        liked_post.destroy if liked_post
    end 
    
    def favorite?(hatapost)
        self.likes.include?(hatapost)
    end 
end
