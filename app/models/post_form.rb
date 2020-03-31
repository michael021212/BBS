class PostForm
  include ActiveModel::Model

  attr_accessor :user_id, :title, :nickname, :body, :category_ids

  validates :title, presence: true, length: { maximum: 30 }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :category_ids, presence: true, :length => {
    :maximum   => 5,
    :too_long  => "は５個以内で選択してください"
  }
  validates :body, presence: true, length: { maximum: 200 }

  def save
    return false if invalid?
    post = Post.new(user_id: user_id, title: title, nickname: nickname)
    post.comments.build(user_id: user_id, body: body, nickname: nickname)
    category_ids.each do |ci|
      post.category_posts.build(category_id: ci.to_i) if !ci.empty?
    end
    return post.save
  end
end
