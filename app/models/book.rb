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
class Book < ApplicationRecord
  GENRES = [
    'Sci-Fi',
    'Horror',
    'Historical',
    'Science Fiction',
    'Romance',
    'Biographic'
  ]

  belongs_to :author

  validates :genre, inclusion: { in: GENRES }

  scope :by_author_name, ->(name) { joins(:author).merge(Author.where('name LIKE ?', "%#{name}%")).distinct }
  scope :by_genre, ->(genre) { where(genre: genre) }
  scope :by_alphabetic_order, -> { order(title: :desc) }

  def type?
    if genre == 'Historical' || genre == 'Biographic'
      'Non-fiction'
    else
      'Fiction'
    end
  end
end
