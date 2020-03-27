class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :categories, through: :category_posts
  has_many :category_posts
  accepts_nested_attributes_for :category_posts
end
