require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'name must not be blank:' do
    let(:user) do
      user = User.new(name: 'Roberto', email: 'roberto@mail.com', password: 'valido', password_confirmation: 'valido')
      user.confirm
      user
    end
    subject!(:group) { Group.create(user:, name: 'Category test 1', icon: 'icon') }

    context 'when is nil' do
      before { group.name = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is an empty string' do
      before { group.name = '' }

      it { is_expected.not_to be_valid }
    end

    context 'when is a blank string' do
      before { group.name = '            ' }

      it { is_expected.not_to be_valid }
    end
  end
end
