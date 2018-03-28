require 'rails_helper'

RSpec.describe 'Transmission', type: :request do
  let(:json_response) { JSON.parse response.body }

  describe 'index' do
    let(:transmissions) { create_list :transmission, 3 }

    before(:each) do
      transmissions
      get '/v1/admin/transmissions'
    end

    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end

    it 'retuns the transmissions' do
      expect(json_response['data'].size).to eq(transmissions.size)
    end

    it 'contains pagination' do
      expect(json_response).to be_jsonapi_paginated
    end
  end

  describe 'create' do
    let(:serializer)   { TransmissionSerializer.new transmission }
    let(:serializered) { ActiveModelSerializers::Adapter.create serializer }

    before(:each) do
      post '/v1/admin/transmissions',
           params: serializered.to_json,
           headers: { 'Content-Type' => 'application/json' }
    end

    context 'when is valid' do
      let(:transmission) { build :transmission }

      it 'responds with 201' do
        expect(response).to have_http_status(201)
      end

      it 'retuns a new transmission' do
        expect(json_response.dig('data', 'id')).to be_present
        expect(json_response.dig('data', 'type')).to eq('transmissions')
      end
    end

    context 'when is NOT valid' do
      let(:transmission) { build :invalid_transmission }

      it 'responds with 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors' do
        expect(json_response['errors'].any?).to be_truthy
      end
    end
  end

  describe 'show' do
    context 'when is found' do
      let(:transmission) { create :transmission, status: :started }

      before(:each) { get "/v1/admin/transmissions/#{transmission.to_param}" }

      it 'responds with 200' do
        expect(response).to have_http_status(200)
      end

      it 'retuns the expected transmission' do
        expect(json_response.dig('data', 'id')).to eq(transmission.id.to_s)
      end
    end

    context 'when is NOT found' do
      before(:each) { get '/v1/admin/transmissions/1' }

      it 'responds with 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'destroy' do
    context 'when is found' do
      let(:transmission) { create :transmission }

      before(:each) do
        delete "/v1/admin/transmissions/#{transmission.to_param}"
      end

      it 'responds with 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
