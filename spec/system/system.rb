require 'rails_helper'

shared_context 'ログインする' do
  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end

shared_context '新規スレッドを作成する' do
  before do
    visit new_post_path
    fill_in 'タイトル', with: 'タイトルA'
    fill_in 'ニックネーム', with: 'ニックネームA'
    check 'post_form_category_ids_1'
    fill_in 'コメント', with: 'コメントA'
    click_button 'スレッドを作成'
  end
end

shared_context '新規コメントを作成する' do
  before do
    visit post_path(Post.first)
    fill_in 'ニックネーム', with: 'ニックネームB'
    fill_in 'コメント', with: 'コメントB'
    click_button '書き込む'
  end
end

describe 'システムテスト', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category_a) { FactoryBot.create(:category, name: 'ニュース') }
  let!(:category_b) { FactoryBot.create(:category, name: '生活') }

  describe '新規スレッド作成機能' do
    context 'ユーザーがログインしている時' do
      include_context 'ログインする'
      include_context '新規スレッドを作成する'

      it 'スレッドが作成される' do
        expect(page).to have_content 'タイトルA'
      end
    end

    context 'ユーザーがログインしていない時' do
      include_context '新規スレッドを作成する'

      it 'ログイン画面に遷移する' do
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '一覧表示機能' do
    include_context 'ログインする'
    include_context '新規スレッドを作成する'

    it '一覧画面に作成したスレッドが表示される' do
      visit posts_path
      expect(page).to have_content 'タイトルA'
    end

    it '一覧画面に登録したカテゴリ名が表示される' do
      visit posts_path
      expect(page).to have_selector '.category_names', text: 'ニュース'
    end

    it '詳細画面に作成したスレッドが表示される' do
      visit post_path(Post.first)
      expect(page).to have_content 'タイトルA'
    end

    it '作成したスレッドにコメントが表示される' do
      visit post_path(Post.first)
      expect(page).to have_content 'コメントA'
    end
  end

  describe '新規コメント作成機能' do
    context 'ユーザーがログインしている時' do
      include_context 'ログインする'
      include_context '新規スレッドを作成する'
      include_context '新規コメントを作成する'

      it 'コメントが作成される' do
        expect(page).to have_content 'コメントB'
      end
    end

    context 'ユーザーがログインしていない時' do
      include_context 'ログインする'
      include_context '新規スレッドを作成する'

      it 'ログイン画面に遷移する' do
        click_link 'ログアウト'
        visit post_path(Post.first)
        fill_in 'ニックネーム', with: 'ニックネームB'
        fill_in 'コメント', with: 'コメントB'
        click_button '書き込む'
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'カテゴリ機能' do
    include_context 'ログインする'

    context '作成したスレッドにつけたカテゴリ名のページに移動する' do
      include_context '新規スレッドを作成する'

      before do
        click_link 'ニュース'
      end

      it '投稿したスレッドが表示される' do
        expect(page).to have_content 'タイトルA'
      end
    end

    context '作成したスレッドにつけていないカテゴリ名のページに移動する' do
      include_context '新規スレッドを作成する'

      before do
        click_link '生活'
      end

      it '投稿したスレッドは表示されない' do
        expect(page).to_not have_content 'タイトルA'
      end
    end

    context 'カテゴリを複数登録する' do
      before do
        visit new_post_path
        fill_in 'タイトル', with: 'タイトルB'
        fill_in 'ニックネーム', with: 'ニックネームA'
        check 'post_form_category_ids_1'
        check 'post_form_category_ids_2'
        fill_in 'コメント', with: 'コメントA'
        click_button 'スレッドを作成'
      end

      it '複数のカテゴリ名が表示される' do
        visit posts_path
        expect(page).to have_selector '.category_names', text: 'ニュース'
        expect(page).to have_selector '.category_names', text: '生活'
      end
    end
  end

  describe '検索機能' do
    include_context 'ログインする'

    before do
      visit new_post_path
      fill_in 'タイトル', with: 'タイトルA'
      fill_in 'ニックネーム', with: 'ニックネームA'
      check 'post_form_category_ids_1'
      fill_in 'コメント', with: 'コメントB'
      click_button 'スレッドを作成'

      visit new_post_path
      fill_in 'タイトル', with: 'タイトルC'
      fill_in 'ニックネーム', with: 'ニックネームA'
      check 'post_form_category_ids_1'
      fill_in 'コメント', with: 'コメントD'
      click_button 'スレッドを作成'
    end

    context '共通のスレッド名で検索' do
      before do
        fill_in 'スレッドタイトルと全レスを検索...', with: 'タイトル'
        click_button '検索'
      end

      it '共通のスレッド名を持つ全スレッドが表示される' do
        expect(page).to have_content 'タイトルA'
        expect(page).to have_content 'タイトルC'
      end
    end

    context '特定のスレッド名で検索' do
      before do
        fill_in 'スレッドタイトルと全レスを検索...', with: 'A'
        click_button '検索'
      end

      it '特定のスレッド名を持たないスレッドは表示されない' do
        expect(page).to_not have_content 'タイトルC'
      end
    end

    context '共通のコメントで検索' do
      before do
        fill_in 'スレッドタイトルと全レスを検索...', with: 'コメント'
        click_button '検索'
      end

      it '共通のコメントを持つ全スレッドが表示される' do
        expect(page).to have_content 'タイトルA'
        expect(page).to have_content 'タイトルC'
      end
    end

    context '特定のコメントで検索' do
      before do
        fill_in 'スレッドタイトルと全レスを検索...', with: 'B'
        click_button '検索'
      end

      it '特定のコメントを持たないスレッドは表示されない' do
        expect(page).to_not have_content 'タイトルC'
      end
    end

    context '存在しない単語で検索' do
      before do
        fill_in 'スレッドタイトルと全レスを検索...', with: 'new_word'
        click_button '検索'
      end

      it 'どのスレッドも表示されない' do
        expect(page).to_not have_content 'タイトルA'
        expect(page).to_not have_content 'タイトルC'
      end
    end
  end
end
