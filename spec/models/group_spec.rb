require 'rails_helper'
require_relative '../shared_file'

RSpec.describe Group, type: :model do
  include_context 'common_context'

  subject!(:group) { user.groups.first }

  describe 'name must not be blank:' do
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
