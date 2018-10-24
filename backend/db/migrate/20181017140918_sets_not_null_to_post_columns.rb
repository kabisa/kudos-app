# frozen_string_literal: true

class SetsNotNullToPostColumns < ActiveRecord::Migration[5.0]
  def change
    change_column_null :posts, :sender_id, false
    change_column_null :posts, :message, false
    change_column_null :posts, :kudos, false
  end
end
