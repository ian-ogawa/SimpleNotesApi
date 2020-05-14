require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  let!(:notes) { create_list(:note, 10) }
  let(:note_id) { notes.first.id }
  let(:response_body) { JSON.parse(response.body) }
  let(:response_code) { response_body['meta']['code'] }
  let(:response_message) { response_body['meta']['message'] }

  describe 'GET /api/v1/notes' do
    before { get '/api/v1/notes' }

    it 'returns notes' do
      expect(json["data"]["notes"]).not_to be_empty
      expect(json["data"]["notes"].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/notes/:id' do
    before { get "/api/v1/notes/#{note_id}" }

    context 'when the record exists' do
      it 'returns the note' do
        expect(json["data"]["notes"]).not_to be_empty
        expect(json["data"]["notes"]['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end

  describe 'POST /api/v1/notes' do
    let(:valid_attributes) { { notes: attributes_for(:note) } }

    context 'when the request is valid' do
      before { post '/api/v1/notes', params: valid_attributes }

      it 'creates a note' do
        expect(json["data"]["notes"]['title']).to eq(valid_attributes[:notes][:title])
        expect(json["data"]["notes"]['content']).to eq(valid_attributes[:notes][:content])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/notes', params: { notes: { title: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response_message["title"].first)
          .to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/notes/:id' do
    let(:valid_attributes) { { notes: { title: 'ipsum' } } }

    context 'when the record exists' do
      before { put "/api/v1/notes/#{note_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json["data"]["notes"]['title']).to eq('ipsum')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/notes', params: { notes: { title: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response_message["title"].first)
          .to match(/can't be blank/)
      end
    end

    context 'when the record does not exist' do
      before { put "/api/v1/notes/15", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    context 'when the record exists' do
      before { delete "/api/v1/notes/#{note_id}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      before { delete "/api/v1/notes/11" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response_message).to match(/Not Found/)
      end
    end
  end
end