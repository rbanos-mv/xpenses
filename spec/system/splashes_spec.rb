require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Splashes', type: :system do
  include_context 'common_context'

  describe 'index page:' do
    context 'when logged in' do
      before(:each) do
        visit root_path
      end

      it 'redirects to groups#index' do
        expect(page).to have_current_path groups_path
      end
    end

    context 'when logged out' do
      before(:each) do
        logout
        visit root_path
      end

      it 'shows the app logo' do
        image = page.all('img')
        expect(image.size).to eq(1)
      end

      it 'has the Log In button' do
        expect(page).to have_selector(:link_or_button, 'Log in')
      end

      it 'has the Sign Up button' do
        expect(page).to have_selector(:link_or_button, 'Sign up')
      end

      context 'when clicking the Log in button' do
        it 'it shows the users/sessions#new' do
          first(:link_or_button, 'Log in').click

          expect(page).to have_current_path new_user_session_path
        end
      end

      context 'when clicking the Sign up button' do
        it 'it shows the devise/registrations#new page' do
          first(:link_or_button, 'Sign up').click

          expect(page).to have_current_path new_user_registration_path
        end
      end
    end
  end
end
