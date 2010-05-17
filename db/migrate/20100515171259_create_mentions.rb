class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
      t.string :description
      t.string :domain
      t.text :embed
      t.string :favicon
      t.string :hash_id
      t.string :image
      t.string :language
      t.string :link
      t.string :source
      t.datetime :timestamp
      t.string :title
      t.string :type
      t.string :user
      t.string :user_id
      t.string :user_image
      t.string :user_link
 
      t.integer :pagerank
      t.integer :num_followers
      t.datetime :register_at
      t.integer :query_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :mentions
  end
end
