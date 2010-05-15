class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
      t.string :type
      t.text :context
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
