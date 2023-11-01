# frozen_string_literal: true

# spec/controllers/v2/admins_controller_spec.rb

require 'rails_helper'

RSpec.describe V2::AdminsController do
  let(:admin) { create(:admin) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { attributes_for(:admin) }
      let(:request) { post :create, params: { admin: params } }

      it 'creates a new admin and returns a JSON response with a 201 status', :aggregate_failures do
        expect { request }.to change(Admin, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { attributes_for(:admin, name: nil) }
      let(:request) { post :create, params: { admin: params } }

      it 'returns a JSON response with unprocessable_entity status', :aggregate_failures do
        expect { request }.not_to change(Admin, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:params) { attributes_for(:admin) }
      let(:request) { put :update, params: { phone: admin.phone, admin: params } }

      it 'updates the admin', :aggregate_failures do
        expect { request }.to change { admin.reload.name }.to(params[:name])
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { attributes_for(:admin, name: nil) }
      let(:request) { put :update, params: { phone: admin.phone, admin: params } }

      it 'returns a JSON response with unprocessable_entity status', :aggregate_failures do
        expect { request }.not_to change { admin.reload.name }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:request) { delete :destroy, params: { phone: admin.phone } }

    it 'destroys the admin', :aggregate_failures do
      admin
      expect { request }.to change(Admin, :count).from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
