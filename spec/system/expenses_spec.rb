require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Expenses', type: :system do
  include_context 'common_context'

  describe 'index page:' do
    before(:each) do
      name = 'Category 14'
      group = user.groups.where(name:).first

      visit group_expenses_path(group.id)
    end

    it 'shows the page header' do
      expect(page).to have_content('EXPENSES')
    end

    it 'has some expenses in the list' do
      lis = page.all('li')
      expect(lis.size.positive?).to be true
    end
  end
end
