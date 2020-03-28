class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :category_posts, dependent: :destroy
  has_many :categories, through: :category_posts
  accepts_nested_attributes_for :category_posts

  validates :title, presence: true, length: { maximum: 30 }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :category_ids, presence: true
end
