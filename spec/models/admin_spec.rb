# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:properties).dependent(:destroy) }
    it { is_expected.to have_many(:amounts).dependent(:nullify) }
  end

  describe 'factories' do
    let(:admin) { create(:admin) }

    it { expect { admin }.to change(described_class, :count).from(0).to(1) }
  end
end
