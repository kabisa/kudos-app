# frozen_string_literal: true

class CreatePostReceivers < ActiveRecord::Migration[5.0]
  def change
    create_table :post_receivers do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
