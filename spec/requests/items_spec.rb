require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:todo) {create(:todo)}
  let!(:items) {create_list(:item), 20, todo_id: todo.id}
  let(:todo_id) {todo.id}
  let(:id) {items.first.id}

  describe 'GET /todos/:todo_id/items' do
    before {get '/todos/#{todo_id}/items'}
    context 'when todo exits' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns todos items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns error message' do
        expect(response.message).to match(/Could not find todo/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }
    context 'when it creates' do
      before {post '/todos/:todo_id/items', params: valid_attributes}
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      it 'returns ' do
        expect(response.body).to match(//)
      end
    end
  end
end
