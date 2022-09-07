require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Groups', type: :request do
  include_context 'common_context'

  describe 'action groups#create' do
    context 'with valid parameters' do
      let(:params) { { group: { name: 'Gas', icon: 'icon' } } }
      let!(:count_before) { user.groups.count }

      before(:each) { post groups_path params: }

      it 'redirect to /groups' do
        expect(response).to redirect_to(groups_path)
      end

      it 'has the name of the last inserted group' do
        expect(user.groups.last.name).to eq(params[:group][:name])
      end

      it 'adds one group to the group\'s collection' do
        expect(user.groups.count).to eq(count_before + 1)
      end

      it 'has correct placeholder text' do
        expect(response.body).to include(groups_path)
      end
    end
  end

  describe 'action groups#index' do
    before(:each) { get groups_path }

    context 'when NOT logged in' do
      before(:each) do
        logout
        get groups_path
      end

      it 'redirect to /users/sign_in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      it 'returns http_success' do
        expect(response).to have_http_status(:success)
      end

      it 'Renders index template' do
        expect(response).to render_template('index')
      end

      it 'Has correct placeholder text' do
        expect(response.body).to include('<h1>Categories</h1>')
      end
    end
  end

  describe 'action groups#new' do
    before(:each) { get new_group_path }

    it 'returns http_success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders new template' do
      expect(response).to render_template('new')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('New Category')
    end
  end

  describe 'action groups#show' do
    let(:group) { user.groups.first }
    before(:each) { get group_path(id: group.id) }

    it 'returns http_success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders show template' do
      expect(response).to render_template('show')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Groups#show')
    end
  end
end
