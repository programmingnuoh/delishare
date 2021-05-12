require 'rails_helper'

RSpec.describe "Delis", type: :request do
  describe "INDEX" do
    before do
      @deli = FactoryBot.create(:deli)
      # @user = User.create(name:'sample', email:"aaa@yahoo.com", password:"sample00", password_confirmation:'sample00')
      # @deli = Deli.create(name:'test', text:'test', category_id:1, supermarket_id:1, user_id:1)
    end

    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq(200)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みの惣菜名が存在する' do
      get root_path
      expect(response.body).to include(@deli.name)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みの画像が存在する' do
      get root_path
      expect(page).to have_selector(@deli.image)
    end

    it 'indexアクションにリクエストするとレスポンスにカテゴリー名が存在する' do
      get root_path
      expect(response.body).to include(@deli.category.name)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿者のユーザー名が存在する' do
      get root_path
      expect(response.body).to include(@deli.user.name)
    end
  end

  describe "SHOW" do
    before do
      @deli = FactoryBot.create(:deli)
    end

    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get deli_path(@deli)
      expect(response.status).to eq(200)
    end

  end
end
