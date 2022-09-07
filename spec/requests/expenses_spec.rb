require 'rails_helper'
require_relative '../shared_file'

RSpec.describe 'Expenses', type: :request do
  include_context 'common_context'

  let(:group) { user.groups.first }

  describe 'action expenses#create' do
    context 'with valid parameters' do
      let(:params) { { expense: { name: 'Gas', amount: 1.1 } } }
      let!(:count_before) { user.expenses.count }

      before(:each) { post group_expenses_path(group_id: group.id), params: }

      it 'redirect to /expenses' do
        expect(response).to redirect_to(group_expenses_path(group_id: group.id))
      end

      it 'has the name of the last inserted expense' do
        expect(user.expenses.first.name).to eq(params[:expense][:name])
      end

      it 'adds one expense to the expense\'s collection' do
        expect(user.expenses.count).to eq(count_before + 1)
      end

      it 'has correct placeholder text' do
        expect(response.body).to include(group_expenses_path(group_id: group.id))
      end
    end
  end

  describe 'action expenses#index' do
    before(:each) { get group_expenses_path(group_id: group.id) }

    context 'when NOT logged in' do
      before(:each) do
        logout
        get group_expenses_path(group_id: group.id)
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
        expect(response.body).to include('<h1>Expenses</h1>')
      end
    end
  end

  describe 'action expenses#new' do
    before(:each) { get new_group_expense_path(group_id: group.id) }

    it 'returns http_success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders new template' do
      expect(response).to render_template('new')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('<h1>New Expense</h1>')
    end
  end

  describe 'action expenses#show' do
    let(:expense) { user.expenses.first }
    before(:each) { get group_expense_path(group_id: group.id, id: expense.id) }

    it 'returns http_success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders new template' do
      expect(response).to render_template('show')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Expenses#show')
    end
  end
end
