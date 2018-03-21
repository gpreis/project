require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { expect(subject).to validate_presence_of :email }
    it { expect(subject).to validate_presence_of :uid }
    it { expect(subject).to validate_presence_of :provider }
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_presence_of :nickname }
    it { expect(subject).to validate_presence_of :type }

    it { expect(subject).to validate_inclusion_of(:type).in_array Account::TYPES }
  end
end
