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
