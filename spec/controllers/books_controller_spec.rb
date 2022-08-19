require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:author) { create(:author) }
  let(:book) { create(:book, author: author) }

  describe '#index' do
    before do
      get :index
    end

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    before do
      sign_in(author)
      get :new, params: {
        author_id: author.id
      }
    end

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    before do
      sign_in(author)
      get :edit, params: {
        author_id: author.id,
        id: book.id
      }
    end

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#destroy' do
    before do
      sign_in(author)
      get :destroy, params: {
        author_id: author.id,
        id: book.id
      }
    end

    it 'deletes a book record' do
      expect { book.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
