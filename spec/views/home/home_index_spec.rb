require 'rails_helper'

RSpec.describe 'Login', type: :system, js: true do
  describe 'Home page' do
    before(:each) do
      visit root_path
    end

    it 'It should display the name of the app' do
      expect(page).to have_content('Welcome to My Budget App')
    end

    it 'It should display the login button' do
      expect(page).to have_content('Log In')
    end

    it 'It should display the login button' do
      expect(page).to have_content('Sign Up')
    end

    it 'It should redirect to login page' do
      click_link 'Log In'
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'It should redirect to sign up page' do
      click_link 'Sign Up'
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  describe 'Login page' do
    before(:each) do
      @user = User.create(name: 'Belay Birnahu', email: 'borntodie2129@gmail.com', password: '12345678')
      sign_in @user
      visit categories_path
    end

    it 'It should display categories' do
      expect(page).to have_current_path(categories_path)
    end

    it "It should display 'Category' name on the navbar" do
      expect(page).to have_content('Category')
    end
  end
end
