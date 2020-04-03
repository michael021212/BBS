# BBS

「BBS」は、某ネット掲示板のようなアプリです。
美しいコードをテーマに作ってみました。

URL: http://18.178.170.188/

## 機能一覧:

* ユーザー認証機能(devise)
* スレッドの投稿・閲覧機能
* コメント(レス)の投稿・閲覧機能
* カテゴリ機能(スレッドごと / 1つのスレッドに複数付与可能)
* カテゴリ別ソート機能
* 検索機能(単語部分検索 / スレッド名及びコメント(レス)の横断検索)(ransack)
* ページネーション機能(kaminari)

## 使用技術一覧:

### 言語・FW

* Ruby 2.5.7
* Rails 5.2.4.2


### 開発環境

* Vagrant + VirtualBox

### インフラ

* AWS(EC2、RDS)、MySQL2、Nginx(WEBサーバ)

### その他使用技術

* Rspec(システムテスト、モデルテスト)
* Slim
* I18n (日本語化)
* better_errors / binding_of_caller (エラー画面のカスタマイズ)
* dotenv-rails (環境変数管理)
* bootstrap4
* Rubocop (VSCodeのエクステンションで静的コード解析)
