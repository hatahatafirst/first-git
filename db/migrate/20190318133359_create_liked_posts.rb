class CreateLikedPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :liked_posts do |t|
      t.references :user, foreign_key: true
      t.references :hatapost, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :hatapost_id], unique: true
    end
  end
end
