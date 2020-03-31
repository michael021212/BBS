categories = %w[ニュース 生活 アイドル 学問 スポーツ 音楽 本 ゲーム PC 会社 文化 食文化 雑談 趣味 乗り物 芸能 旅行]
categories.each do |name|
  Category.create(name: name)
end

User.create(name: '山田太郎', email: 'yamada@y', password: '000000')

Post.create(user_id: 1, title: '【悲報】オリンピック延期', nickname: 'やまだ')

Comment.create(user_id: 1, post_id: 1, body: 'しょうがないね', nickname: 'やまだ')

CategoryPost.create(category_id: 1, post_id: 1)