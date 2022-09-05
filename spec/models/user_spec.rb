require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'name must not be blank:' do
    subject!(:user) do
      user = User.new(name: 'Roberto', email: 'roberto@mail.com', password: 'valido', password_confirmation: 'valido')
      user.confirm
      user
    end

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
end
