require 'rails_helper'

RSpec.describe 'Delis', type: :system do
  before do
    @user = FactoryBot.create(:user)
    # @deli = FactoryBot.build(:deli, user_id:@user.id, category_id: 1)
    # @user = User.create(name:'sample', email:"aaa@yahoo.com", password:"sample00", password_confirmation:'sample00')
    # @deli = Deli.new(name:'test', text:'test', category_id:2, supermarket_id:1, user_id:1)
  end

  context '投稿ができる時' do
    it 'ログインしたユーザーは新規投稿ができる' do
      sign_in(@user)
      expect(page).to have_content('New Deli')
      visit new_deli_path
      expect(current_path).to eq(new_deli_path)
      fill_in 'deli[name]', with: 'test'
      fill_in 'deli[text]', with: 'test'
      choose ('deli_category_id_1')
      select 'ヤオコー', from: 'deli[supermarket_id]'
      image_path = Rails.root.join('public/images/testimage.jpg')
      attach_file('deli[image]', image_path, make_visible: true)
      
      # expect {
        find('input[name="commit"]').click
      # }.to change { Deli.count }.by(1)
      # binding.pry
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@deli.name)
    end
  end

  context '投稿ができない時' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      visit root_path
      expect(page).to have_no_content('New Deli')
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @deli1 = FactoryBot.create(:deli)
    @deli2 = FactoryBot.create(:deli)
  end
  context '投稿編集ができる時' do
    it 'ログインしたユーザーは自分が投稿した記事の編集ができる' do
      sign_in(@deli1.user)
      visit deli_path(@deli1)
      expect(page).to have_content("編集")
      visit edit_deli_path(@deli1)
      expect(
        find('#deli_name.deli-form').value
      ).to eq @deli1.name
      expect(
        find('#deli_text.deli-form').value
      ).to eq @deli1.text
      fill_in 'deli[name]', with: 'test+test'
      fill_in 'deli[name]', with: 'test+test+test'
      choose 'deli_category_id_2'
      select 'ユニー', from: 'deli[supermarket_id]'
      expect{
        find('input[name="commit"]').click
      }.to change {Deli.count}.by(0)
      expect(current_path).to eq deli_path(@deli1)
      expect(page).to have_content('test+test')
      expect(page).to have_content('test+test+test')
    end
  end

  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の編集ボタンが表示されない' do
      sign_in(@deli1.user)
      visit deli_path(@deli2)
      expect(page).to have_no_content("編集")
    end

    it 'ログインしたユーザーは自分以外が投稿した記事の編集ページのURLを直接入力しても詳細ページに戻る' do
      sign_in(@deli1.user)
      visit edit_deli_path(@deli2)
      expect(current_path).to eq(deli_path(@deli2))
    end

    it 'ログインしていないユーザーは記事の編集ページのURLを直接入力してもログインページに遷移する' do
      visit edit_deli_path(@deli1)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '投稿削除' do
  before do
    @deli1 = FactoryBot.create(:deli)
    @deli2 = FactoryBot.create(:deli)
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自分が投稿した記事を削除できる' do
      sign_in(@deli1.user)
      visit deli_path(@deli1)
      expect(page).to have_content("削除")
      visit confirm_deli_path(@deli1)
      expect {
        find_link('削除する', href:deli_path(@deli1)).click
      }.to change{Deli.count}.by(-1)
      expect(current_path).to eq(deli_path(@deli1))
      expect(page).to have_content('投稿を削除しました')
      find_link('TOPページへ戻る', href:root_path).click
      expect(page).to have_no_content("#{@deli1.name}")
    end
  end

  context '投稿削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の削除ボタンが表示されない' do
      sign_in(@deli1.user)
      visit deli_path(@deli2)
      expect(page).to have_no_content("削除")
    end

    it 'ログインしたユーザーは自分以外が投稿した記事の削除ページのURLを直接入力しても詳細ページに戻る' do
      sign_in(@deli1.user)
      visit confirm_deli_path(@deli2)
      expect(current_path).to eq(deli_path(@deli2))
    end

    it 'ログインしていないユーザーは記事の削除ページのURLを直接入力してもログインページに遷移する' do
      visit confirm_deli_path(@deli1)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end