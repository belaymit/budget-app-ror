require 'rails_helper'

RSpec.describe 'Expenses', type: :system, js: true do
  describe 'Expenses page' do
    before(:each) do
      @user = User.create(name: 'Belay Birhanu', email: 'borntodie2129@gmail.com', password: '12345678')
      sign_in @user

      @category = Category.create(author: @user, name: 'Electronics',
                                  icon: 'https://m.media-amazon.com/images/I/611ovP2GkrL.jpg')
      @expense = Expense.create(author: @user, name: 'iPhone 13 pro', amount: 1200)
      @category_expense = CategoryExpense.create(category: @category, expense: @expense)
      visit category_expenses_path(@category)
    end

    it 'Should display transaction on the navbar name' do
      expect(page).to have_content('Transaction')
    end

    it 'Should display expense name' do
      expect(page).to have_content(@expense.name)
    end

    it 'Should display add new transaction button' do
      expect(page).to have_content('Add a new Transaction')
    end

    it 'Should display category icon' do
      expect(page.body).to include(@category.icon)
    end

    it 'Should display category created date' do
      expect(page).to have_content(@expense.created_at.strftime('%d %b %Y'))
    end
  end
end
