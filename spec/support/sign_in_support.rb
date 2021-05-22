module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    sleep(3)
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end