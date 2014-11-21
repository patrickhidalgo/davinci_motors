require 'rails_helper'

feature 'User Authentication' do
  scenario 'allows a user to signup' do
    visit '/'

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First name', with: 'bob'
    fill_in 'Last name', with: 'smith'
    fill_in 'Email', with: 'bob@smith.com'
    fill_in 'Password', with: 'sup3rs3krit'
    fill_in 'Password Confirmation', with: 'sup3rs3krit'

    click_button 'Signup'

    expect(page).to have_text('Thank you for signing up Bob')
    expect(page).to have_text('Signed in as bob@smith.com')
  end

  scenario 'allows existing users to login' do
    user = FactoryGirl.create(:user)

    visit '/'

    expect(page).to have_link('Login')

    click_link('Login')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Login'

    expect(page).to have_text("Welcome back #{user.first_name.titleize}")
    expect(page).to have_text("Signed in as #{user.email}")
  end

  scenario 'does not allow existing users to login with an invalid password' do
    user = FactoryGirl.create(:user, password: 'sup3rs3crit')

    visit '/'

    expect(page).to have_link('Login')

    click_link('Login')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'NOT_YOUR_PASSWORD'

    click_button 'Login'

    expect(page).to have_text('Invalid email or password')
  end

  scenario 'allows a logged in user to log out' do
    user = FactoryGirl.create(:user, password: 'sup3rs3crit')

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Login'

    visit '/'

    expect(page).to have_text("Signed in as #{user.email}")
    expect(page).to have_link('Logout')

    click_link('Logout')

    expect(page).to have_text("#{user.email} has logged out.")
    expect(page).to_not have_text("Welcome back #{user.first_name.titlecase}")
    expect(page).to_not have_text("Signed in as #{user.email}")
  end

end

