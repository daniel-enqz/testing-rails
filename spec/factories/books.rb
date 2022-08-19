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
require 'faker'

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    genre { 'Horror' }
    author { nil }
  end

  trait :non_fiction do
    genre { 'Historical' }
  end

  trait :fiction do
    genre { 'Sci-Fi' }
  end
end
