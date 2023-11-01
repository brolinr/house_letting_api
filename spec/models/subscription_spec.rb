# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:poll_url) }
    it { is_expected.to validate_presence_of(:month) }
    it { is_expected.to validate_presence_of(:ecocash_number) }
    it { is_expected.to validate_presence_of(:payment_status) }
    it { is_expected.to validate_presence_of(:fee) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:customer) }
  end

  describe 'factory' do
    let(:subscription) { create(:subscription, :with_customer) }

    it { expect { subscription }.to change(described_class, :count).from(0).to(1) }
    it { expect { subscription }.to change(Customer, :count).from(0).to(1) }
  end
end
