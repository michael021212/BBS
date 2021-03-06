class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true

  validates :body, presence: true, length: { maximum: 200 }
  validates :nickname, presence: true, length: { maximum: 10 }
end
