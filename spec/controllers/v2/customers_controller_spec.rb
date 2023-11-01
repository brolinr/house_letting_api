# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::CustomersController do
  let(:customer) { create(:customer) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { customer: attributes_for(:customer) } }
      let(:request) { post :create, params: params }

      it 'creates a new customer and returns a JSON response with a 201 status', :aggregate_failures do
        expect { request }.to change(Customer, :count).from(0).to(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { customer: nil } }
      let(:request) { post :create, params: params }

      it 'returns a JSON response with unprocessable_entity status', :aggregate_failures do
        expect { request }.not_to change(Customer, :count)
        expect(response).to have_http_status(:internal_server_error)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:params) { { phone: customer.phone, customer: { name: 'Brolin' } } }
      let(:request) { put :update, params: params }

      it 'creates a new customer and returns a JSON response with a 201 status', :aggregate_failures do
        expect { request }.to change(Customer, :count).from(0).to(1)
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { phone: 'invalid', customer: { name: 'Brolin' } } }
      let(:request) { put :update, params: params }

      it 'returns a JSON response with a not_found status', :aggregate_failures do
        expect { request }.not_to change(Customer, :count)
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      let(:params) { { phone: customer.phone } }
      let(:request) { delete :destroy, params: params }

      it 'deletes customer and returns a JSON response with a no_content status', :aggregate_failures do
        customer
        expect { request }.to change(Customer, :count).from(1).to(0)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid params' do
      let(:params) { { phone: 'nil' } }
      let(:request) { delete :destroy, params: params }

      it 'fails to delete customer and returns a JSON response with a not_found status', :aggregate_failures do
        expect { request }.not_to change(Customer, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
