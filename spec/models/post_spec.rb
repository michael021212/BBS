require 'rails_helper'

RSpec.describe Post, 'スレッドのモデルテスト', type: :model do
  context '保存できる場合' do
    it '全て入力してあるので保存される' do
      expect(FactoryBot.create(:post)).to be_valid
    end
  end

  context '保存できない場合' do
    it "タイトルが空欄" do
      expect(FactoryBot.build(:post, :no_title)).to_not be_valid
    end

    it "タイトルが31文字以上" do
      expect(FactoryBot.build(:post, :too_long_title)).to_not be_valid
    end

    it "ニックネームが空欄" do
      expect(FactoryBot.build(:post, :no_nickname)).to_not be_valid
    end

    it "ニックネームが11文字以上" do
      expect(FactoryBot.build(:post, :too_long_nickname)).to_not be_valid
    end
  end
end
