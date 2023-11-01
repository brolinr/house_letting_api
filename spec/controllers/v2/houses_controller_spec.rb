# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::HousesController do
  let(:property) { create(:property, :with_admin) }
  let(:admin) { property.admin }

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { admin_phone: admin.phone, house: attributes_for(:property) } }
      let(:request) { post :create, params: params }

      it 'create house and return JSON data with created HTTP status', :aggregate_failures do
        expect { request }.to change(Property, :count).from(0).to(2)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { phone: 'invalid', house: attributes_for(:property) } }
      let(:request) { post :create, params: params }

      it 'not create house and return JSON data with HTTP status internal server error', :aggregate_failures do
        expect { request }.not_to change(Property, :count)
        expect(response).to have_http_status(:internal_server_error)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:params) { { admin_phone: admin.phone, id: property.id, house: { owner_email: 'foo@bar.baz' } } }
      let(:request) { put :update, params: params }

      it 'updates property and returns JSON data and HTTP status OK', :aggregate_failures do
        expect(Property.count).to eq(0)
        expect { request }.to change { Property.last.reload.owner_email }.to(params[:house][:owner_email])
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      let(:params) { { admin_phone: 'invalid', id: 'invalid', house: { owner_email: 'foo@bar.baz' } } }
      let(:request) { put :update, params: params }

      it 'does not update property and returns JSON data and HTTP status Not Found', :aggregate_failures do
        property
        expect { request }.not_to change { Property.last.owner_email }
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      let(:params) { { admin_phone: admin.phone, id: property.id } }
      let(:request) { delete :destroy, params: params }

      it 'destroys property and return JSON data and HTTP status ok', :aggregate_failures do
        property
        expect { request }.to change(Property, :count).from(1).to(0)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid params' do
      let(:params) { { admin_phone: 'invalid', id: 'invalid' } }
      let(:request) { delete :destroy, params: params }

      it 'does not destroy property and returns JSON data and HTTP status not_found', :aggregate_failures do
        property
        expect { request }.not_to change(Property, :count)
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
