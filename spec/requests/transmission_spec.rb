require 'rails_helper'

RSpec.describe 'Transmission', type: :request do
  let(:json_response) { JSON.parse response.body }

  describe 'index' do
    let(:transmissions) { create_list :transmission, 3 }

    before(:each) do
      transmissions
      get '/v1/transmissions'
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

  %w[confirmed started].each do |status|
    describe "index scoped by status #{status}" do
      before(:each) do
        Transmission::STATUS.each { |s| create :transmission, status: s }
        get "/v1/transmissions/#{status}"
      end

      it 'responds with 200' do
        expect(response).to have_http_status(200)
      end

      it "retuns the #{status} transmissions" do
        collection = json_response['data']

        expect(collection.size).to eq(1)
        expect(collection.first.dig('attributes', 'status')).to eq(status)
      end

      it 'contains pagination' do
        must_links = %w[self first prev next last]

        expect(json_response['links'].keys).to contain_exactly(*must_links)
      end
    end
  end

  describe 'show' do
    context 'when exists and status is started' do
      let(:transmission) { create :transmission, status: :started }

      before(:each) { get "/v1/transmissions/#{transmission.to_param}" }

      it 'responds with 200' do
        expect(response).to have_http_status(200)
      end

      it 'retuns the expected transmission' do
        expect(json_response.dig('data', 'id')).to eq(transmission.id.to_s)
      end
    end

    context 'when exists and status is not started' do
      let(:transmission) { create :transmission, status: :confirmed }

      before(:each) { get "/v1/transmissions/#{transmission.to_param}" }

      it 'responds with 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when not exists' do
      before(:each) { get '/v1/transmissions/1' }

      it 'responds with 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
