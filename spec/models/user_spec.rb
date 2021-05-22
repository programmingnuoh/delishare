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
      it "nameが空だとユーザー登録ができない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it "emailが空だとユーザー登録ができない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@がついていないと登録ができない" do
        @user.email = "aiueiaiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailはすでに登録しているデータと同じだと登録ができない" do
        @other_user = FactoryBot.create(:user)
        @user.email = @other_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空だとユーザー登録ができない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "password_confirmationが空だとユーザー登録ができない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordとpassword_confirmationが一致しないと登録ができない" do
        @user.password_confirmation = "aiueoaiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordが6文字未満だと登録ができない" do
        @user.password = "aiue0"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが英字のみだと登録ができない" do
        @user.password = "aiueoaiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "passwordが半角数字のみだと登録ができない" do
        @user.password = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "passwordが全角で入力されていると登録ができない" do
        @user.password = "ＡＡＡＡＡＡ０００"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end
  end
end
