class Post < ApplicationRecord
  validates :sender, presence: true
  validates :receivers, presence: true
  validates :message, presence: true
  validates :kudos, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }

  belongs_to :sender, class_name: 'User'

  has_many :post_receivers,
           dependent: :destroy
  has_many :receivers,
           through: :post_receivers,
           source: :user
end
