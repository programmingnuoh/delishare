require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
  end

  context "ログインの有無による表示の違い" do
    it "ログアウト状態だとログインと新規登録の表示がある" do
      visit root_path
      expect(page).to have_content("ログイン")
      expect(page).to have_content("新規登録")
    end

    it "ログイン状態だとユーザー名とログアウトの文字がある" do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      visit root_path
      expect(page).to have_content(@user.name)
      expect(page).to have_content("ログアウト")
    end
  end
end

RSpec.describe '新規登録、ログインについて', type: :system do
  it "新規登録ページで各項目を入力するとユーザーの新規登録ができる" do
    @user = FactoryBot.build(:user)
    visit new_user_registration_path
    expect(current_path).to eq(new_user_registration_path)
    fill_in 'name', with:@user.name
    fill_in 'email', with:@user.email
    fill_in 'password', with:@user.password
    fill_in 'password_confirmation', with:@user.password_confirmation
    expect {
      find('input[name="commit"]').click
    }.to change{User.count}.by(1)
    expect(current_path).to eq(root_path)
    expect(page).to have_content(@user.name)    
  end

  context "ログインの流れ" do
    before do
      @user = FactoryBot.create(:user)      
    end
    it "ログインページで各項目を入力するとログインができる" do
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on('Log In')
      expect(current_path).to eq root_path
    end

    it "ログアウトボタンを押すことでユーザーがログアウトできること" do
      sign_in(@user)
      click_on('ログアウト')
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
end

RSpec.describe '詳細ページに関して', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  it 'ログインしていなくてもユーザー詳細ページを見ることができる' do
    visit user_path(@user1)
    expect(current_path).to eq(user_path(@user1))
  end

  it '本人のみ「プロフィールを編集」ボタンが表示される' do
    sign_in(@user1)
    visit user_path(@user1)
    expect(page).to have_content('プロフィールを編集')
  end

  it '本人以外には「プロフィールを編集」ボタンが表示されない' do
    sign_in(@user2)
    visit user_path(@user1)
    expect(page).to have_no_content('プロフィールを編集')
  end
end

RSpec.describe '編集ページに関して' do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context 'ページ遷移について' do
    it '本人のみユーザー編集ページに遷移できる' do
      sign_in(@user1)
      visit edit_user_path(@user1)
      expect(current_path).to eq(edit_user_path(@user1))
    end

    it '本人以外はユーザー編集ページに遷移できない' do
      sign_in(@user2)
      visit user_path(@user1)
      expect(current_path).to eq(user_path(@user1))
    end
  end

  context '編集ページの入力に関するテスト' do
    it '全ての項目を入力するとユーザー情報を更新できる' do
      sign_in(@user1)
      visit edit_user_path(@user1)
      image_path = Rails.root.join('public/images/testimage.jpg')
      attach_file('user[image]', image_path, make_visible: true)
      fill_in 'user_introduction', with: 'test'
      click_on('保存する')
      expect(current_path).to eq(user_path(@user1))
      expect(page).to have_content('test')
    end

    it 'introductionが空でも保存ができる' do
      sign_in(@user1)
      visit edit_user_path(@user1)
      fill_in 'user_introduction', with: ''
      click_on('保存する')
      expect(current_path).to eq(user_path(@user1))
    end
  end
end