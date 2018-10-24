# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, :password_digest, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :sent_posts,
           class_name: "Post",
           foreign_key: "sender_id",
           dependent: :destroy

  has_many :post_receivers,
           dependent: :destroy
  has_many :received_posts,
           through: :post_receivers,
           source: :post
end
