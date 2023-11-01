# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::AmountsController do
  let(:amount) { create(:amount) }
  let(:admin) { create(:admin) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { admin_phone: admin.phone, amount: { price: rand(7000) } } }
      let(:request) { post :create, params: params }

      it 'creates a new amount and returns a JSON response with a 201 status', :aggregate_failures do
        expect { request }.to change(Amount, :count).from(0).to(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { admin_phone: admin.phone, amount: { price: nil } } }
      let(:request) { post :create, params: params }

      it 'returns a JSON response with unprocessable_entity status', :aggregate_failures do
        expect { request }.not_to change(Amount, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
