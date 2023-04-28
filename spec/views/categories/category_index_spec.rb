require 'rails_helper'

RSpec.describe 'Categories', type: :system, js: true do
  describe 'categories page' do
    before(:each) do
      @user = User.create(name: 'Belay Birhanu', email: 'borntodie2129@gmail.com', password: '12345678')
      sign_in @user

      @category = Category.create(author: @user,
                                  name: 'Electronics',
                                  icon: 'https://m.media-amazon.com/images/I/611ovP2GkrL.jpg')
      visit categories_path
    end

    it 'Should display category name' do
      expect(page).to have_content(@category.name)
    end

    it 'Should display category icon' do
      expect(page.body).to include(@category.icon)
    end

    it 'Should display created_date' do
      expect(page).to have_content(@category.created_at.strftime('%d %b %Y'))
    end

    it 'Should display the sum of categories expense' do
      expect(page).to have_content(@category.expenses.sum(:amount))
    end

    it 'Should display add new category button' do
      expect(page).to have_content('Add New Category')
    end

    it 'Should add new category' do
      click_link 'Add New Category'
      expect(page).to have_content('New Category')
    end

    it 'Should redirect to expense page' do
      click_link @category.name
      expect(page).to have_current_path(category_expenses_path(@category))
    end
  end
end
