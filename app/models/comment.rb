class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 30 }
  validates :nickname, presence: true, length: { maximum: 10 }
end
