class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
      t.string :m_description
      t.string :m_domain
      t.text :m_embed
      t.string :m_favicon
      t.string :m_id
      t.string :m_image
      t.string :m_language
      t.string :m_link
      t.string :m_source
      t.datetime :m_timestamp
      t.string :m_title
      t.string :m_type
      t.string :m_user
      t.string :m_user_id
      t.string :m_user_image
      t.string :m_user_link
 
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
