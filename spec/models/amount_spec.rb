# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Amount do
  describe 'relations' do
    it { is_expected.to belong_to(:admin) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'factories' do
    let(:amount) { create(:amount) }

    it { expect { amount }.to change(described_class, :count).from(0).to(1) }
    it { expect { amount }.to change(Admin, :count).from(0).to(1) }
  end
end
