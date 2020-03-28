categories = %w[ニュース 生活 アイドル 学問 スポーツ 音楽 本 ゲーム PC 会社 文化 食文化 雑談 趣味 乗り物 芸能 旅行]
categories.each do |name|
  Category.create(name: name)
end

User.create(name: '山田太郎', email: 'yamada@y', password: '000000')
