require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Splash', type: :request do
  include_context 'common_context'

  describe 'action splash#index:' do
    before(:each) { get root_path }

    context 'when NOT logged in' do
      before(:each) do
        logout
        get root_path
      end

      it 'shows page content' do
        expect(response.body).to include('Splash#index')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when logged in' do
      it 'redirect to /groups/' do
        expect(response).to redirect_to(groups_path)
      end
    end
  end
end
