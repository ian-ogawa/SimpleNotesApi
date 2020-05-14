require 'rails_helper'

RSpec.describe 'Labels API', type: :request do
  let!(:labels) { create_list(:label, 10) }
  let(:label_id) { labels.first.id }
  let(:response_body) { JSON.parse(response.body) }
  let(:response_code) { response_body['meta']['code'] }
  let(:response_message) { response_body['meta']['message'] }

  describe 'GET /api/v1/labels' do
    before { get '/api/v1/labels' }

    it 'returns labels' do
      expect(json["data"]["labels"]).not_to be_empty
      expect(json["data"]["labels"].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/labels/:id' do
    before { get "/api/v1/labels/#{label_id}" }

    context 'when the record exists' do
      it 'returns the label' do
        expect(json["data"]["labels"]).not_to be_empty
        expect(json["data"]["labels"]['id']).to eq(label_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:label_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end

  describe 'POST /api/v1/labels' do
    let(:valid_attributes) { { labels: attributes_for(:label) } }

    context 'when the request is valid' do
      before { post '/api/v1/labels', params: valid_attributes }

      it 'creates a label' do
        expect(json["data"]["labels"]['name']).to eq(valid_attributes[:labels][:name])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/labels', params: { labels: { name: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response_message["name"].first)
          .to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/labels/:id' do
    let(:valid_attributes) { { labels: { name: 'Ipsum' } } }

    context 'when the record exists' do
      before { put "/api/v1/labels/#{label_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json["data"]["labels"]['name']).to eq('Ipsum')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/labels', params: { labels: { name: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response_message["name"].first)
          .to match(/can't be blank/)
      end
    end

    context 'when the record does not exist' do
      before { put "/api/v1/labels/15", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end

  describe 'DELETE /api/v1/labels/:id' do
    context 'when the record exists' do
      before { delete "/api/v1/labels/#{label_id}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      before { delete "/api/v1/labels/11" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end
end