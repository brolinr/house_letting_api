# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::FeedbacksController do
  let(:customer) { create(:customer) }
  let(:feedback) { create(:feedback, customer: customer) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { phone: customer.phone, feedback: attributes_for(:feedback) } }
      let(:request) { post :create, params: params }

      it 'creates feedback and return JSON and a created HTTP status', :aggregate_failures do
        expect { request }.to change(Feedback, :count).from(0).to(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { phone: 'invalid', feedback: nil } }
      let(:request) { post :create, params: params }

      it 'does not create feedback and return internal server error', :aggregate_failures do
        expect { request }.not_to change(Feedback, :count)
        expect(response).to have_http_status(:internal_server_error)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
