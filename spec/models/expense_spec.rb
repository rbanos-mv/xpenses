require 'rails_helper'
require_relative '../shared_file'

RSpec.describe Expense, type: :model do
  include_context 'common_context'

  subject!(:expense) { Expense.where(user:).first }

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
