require 'rails_helper'

RSpec.describe Comment, 'コメントのモデルテスト', type: :model do
  context '保存できる場合' do
    it '全て入力してあるので保存される' do
      expect(FactoryBot.create(:comment)).to be_valid
    end
  end

  context '保存できない場合' do
    it "コメントが空欄" do
      expect(FactoryBot.build(:comment, :no_body)).to_not be_valid
    end

    it "コメントが201文字以上" do
      expect(FactoryBot.build(:comment, :too_long_body)).to_not be_valid
    end

    it "ニックネームが空欄" do
      expect(FactoryBot.build(:comment, :no_nickname_comment)).to_not be_valid
    end

    it "ニックネームが11文字以上" do
      expect(FactoryBot.build(:comment, :too_long_nickname_comment)).to_not be_valid
    end
  end
end
