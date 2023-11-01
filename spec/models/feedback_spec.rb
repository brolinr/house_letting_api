# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:feedback_type) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:customer) }
  end

  describe 'factories' do
    let(:feedback) { create(:feedback, :with_customer) }

    it { expect { feedback }.to change(described_class, :count).from(0).to(1) }
    it { expect { feedback }.to change(Customer, :count).from(0).to(1) }
  end
end
