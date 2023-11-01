# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:owner_phone) }
    it { is_expected.to validate_presence_of(:owner_whatsapp) }
    it { is_expected.to validate_presence_of(:owner_email) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:admin) }
  end

  describe 'factory' do
    let(:property) { create(:property, :with_admin) }

    it { expect { property }.to change(described_class, :count).from(0).to(1) }
    it { expect { property }.to change(Admin, :count).from(0).to(1) }
  end
end
