# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  describe 'relations' do
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:feedbacks).dependent(:nullify) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }
  end

  describe 'factories' do
    let(:customer) { create(:customer) }

    it { expect { customer }.to change(described_class, :count).from(0).to(1) }
  end
end
