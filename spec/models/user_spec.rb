require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー機能' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー登録ができるとき' do
      it '全ての項目を入力していれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録ができない時' do
    end
  end
end
