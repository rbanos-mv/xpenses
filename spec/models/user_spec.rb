require 'rails_helper'
require_relative '../shared_file'

RSpec.describe User, type: :model do
  include_context 'common_context'

  describe 'name must not be blank:' do
    context 'when is nil' do
      before { user.name = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is an empty string' do
      before { user.name = '' }

      it { is_expected.not_to be_valid }
    end

    context 'when is a blank string' do
      before { user.name = '            ' }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'groups:' do
    it { expect(user.groups.length).to eq(10) }
  end

  describe 'expenses:' do
    it { expect(user.expenses.length).to eq(6) }
  end
end
