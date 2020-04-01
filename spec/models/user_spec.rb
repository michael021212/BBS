require 'rails_helper'

RSpec.describe User, 'ユーザーのモデルテスト', type: :model do
  context '保存できる場合' do
    it '全て入力してあるので保存される' do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end

  context '保存できない場合' do
    it "nameが空欄" do
      expect(FactoryBot.build(:user, :no_name)).to_not be_valid
    end

    it "nameが21文字以上" do
      expect(FactoryBot.build(:user, :too_long_name)).to_not be_valid
    end
  end
end
