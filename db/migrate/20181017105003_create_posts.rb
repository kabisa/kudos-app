class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :sender_id
      t.text :message
      t.integer :kudos

      t.timestamps
    end
  end
end
