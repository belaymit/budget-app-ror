require 'rails_helper'

RSpec.describe 'Categories', type: :system, js: true do
  describe 'categories page' do
    before(:each) do
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-gpu')
      @user = User.create(name: 'Belay Birhanu', email: 'borntodie2129@gmail.com', password: '12345678')
      sign_in @user

      @category = Category.create(author: @user,
         name: 'Electronics', 
         icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7plcZojrHGzx4O4dHV-JZcTf3ZgoldM2p9w&usqp=CAU')
      visit categories_path,  options: options
    end

    it 'It should display category name' do
      expect(page).to have_content(@category.name)
    end

    it 'It should display category icon' do
      expect(page.body).to include(@category.icon)
    end

    it 'It should display created_date' do
      expect(page).to have_content(@category.created_at.strftime('%d %b %Y'))
    end

    it 'It should display the sum of categories expense' do
      expect(page).to have_content(@category.expenses.sum(:amount))
    end

    it 'It should display add new category button' do
      expect(page).to have_content('Add New Category')
    end

    it 'It should add new category' do
      click_link 'Add New Category'
      expect(page).to have_content('New Category')
    end

    it 'It should redirect to expense page' do
      click_link @category.name
      expect(page).to have_current_path(category_expenses_path(@category))
    end
  end
end