require 'rails_helper'

RSpec.describe Deli, type: :model do
  describe '惣菜投稿機能' do
    before do
      @deli = FactoryBot.build(:deli)
    end

    context '惣菜投稿ができる時' do
      it '全ての項目を入力していると投稿できる' do
        expect(@deli).to be_valid
      end
    end

    context '惣菜投稿ができないとき' do
      it '惣菜名が入力されていないと投稿できない' do
        @deli.name = nil
        @deli.valid?
        expect(@deli.errors.full_messages).to include("Name can't be blank")
      end

      it '説明文が入力されていないと投稿できない' do
        @deli.text = nil
        @deli.valid?
        expect(@deli.errors.full_messages).to include("Text can't be blank")
      end

      it 'カテゴリーが選択されていないと投稿できない' do
        @deli.category_id = nil
        @deli.valid?
        expect(@deli.errors.full_messages).to include('Category must exist')
      end

      it '購入した店舗が選択されていないと投稿できない' do
        @deli.supermarket_id = nil
        @deli.valid?
        expect(@deli.errors.full_messages).to include("Supermarket can't be blank")
      end

      it '画像がつけられていないと投稿できない' do
        @deli.image = nil
        @deli.valid?
        expect(@deli.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
