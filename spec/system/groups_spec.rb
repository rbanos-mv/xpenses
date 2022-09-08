require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Groups', type: :system do
  include_context 'common_context'

  describe 'index page:' do
    before(:each) do
      visit groups_path
    end

    it 'shows the page header' do
      expect(page).to have_content('CATEGORIES')
    end

    it 'has 10 categories in the list' do
      lis = page.all('li')
      expect(lis.size).to eq(10)
    end

    context 'when click on the first category' do
      it 'opens the expenses#index page' do
        name = 'Category 10'
        group = user.groups.where(name:).first
        click_on(name)
        expect(page).to have_current_path group_expenses_path(group.id)
      end

      it 'has no expenses' do
        click_on('Category 10')
        expect(page).to have_content('There are no expenses')
      end
    end

    context 'when click on the fourth category' do
      it 'opens the expenses#index page' do
        name = 'Category 13'
        group = user.groups.where(name:).first
        click_on(name)
        expect(page).to have_current_path group_expenses_path(group.id)
      end

      it 'has expenses' do
        click_on('Category 13')
        lis = page.all('li')
        expect(lis.length.positive?).to be true
      end
    end
  end
end
