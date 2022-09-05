require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) do
    user = User.new(name: 'Roberto', email: 'roberto@mail.com', password: 'valido', password_confirmation: 'valido')
    user.confirm
    user
  end
  subject!(:expense) { Expense.create(user:, name: 'Expanse 1', amount: rand(1000..100_000) / 100) }

  describe 'name must not be blank:' do
    context 'when is nil' do
      before { expense.name = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is an empty string' do
      before { expense.name = '' }

      it { is_expected.not_to be_valid }
    end

    context 'when is a blank string' do
      before { expense.name = '            ' }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'Amount must be a decimal greater than zero:' do
    context 'when is nil' do
      before { expense.amount = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is decimal' do
      before { expense.amount = 1.5 }

      it { is_expected.to be_valid }
    end

    context 'when is negative' do
      before { expense.amount = -1.5 }

      it { is_expected.not_to be_valid }
    end
  end
end
