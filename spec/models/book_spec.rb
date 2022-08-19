# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  title      :string           default(""), not null
#  genre      :string           default(""), not null
#  author_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    let(:author) { create(:author) }
    subject { create(:book, author_id: author.id) }

    it { is_expected.to validate_inclusion_of(:genre).in_array(Book::GENRES) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
  end

  describe 'scopes' do
    let!(:author1) { create(:author, name: 'Lisa') }
    let!(:author2) { create(:author, name: 'Bart') }
    let!(:book1) { create(:book, title: 'Animal', author: author1, genre: 'Sci-Fi') }
    let!(:book2) { create(:book, title: 'Zodiac', author: author2, genre: 'Horror') }

    describe '.by_author_name' do
      it 'returns the books of a given author' do
        expect(Book.by_author_name('Lisa')).to include(book1)
      end

      it 'excludes the books of other authors' do
        expect(Book.by_author_name('Lisa')).not_to include(book2)
      end
    end

    describe '.by_genre' do
      it 'returns the books of a given genre' do
        expect(Book.by_genre('Sci-Fi')).to include(book1)
      end

      it 'excludes the books of other genres' do
        expect(Book.by_genre('Sci-Fi')).not_to include(book2)
      end
    end

    describe '.by_alphabetic_order' do
      it 'sorts the books in descending alphabetical order' do
        expect(Book.by_alphabetic_order.first.title).to eq(book2.title)
      end
    end
  end

  describe 'methods' do
    let(:author) { create(:author) }
    let(:book1) { create(:book, :fiction, author: author) }
    let(:book2) { create(:book, :non_fiction, author: author) }
    describe '#type?' do
      it 'returns the type of a book based on its genre' do
        expect(book1.type?).to eq('Fiction')
        expect(book2.type?).to eq('Non-fiction')
      end
    end
  end
end
