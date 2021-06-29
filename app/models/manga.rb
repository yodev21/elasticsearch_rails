class Manga < ApplicationRecord
  include MangaSearch::Engine

  belongs_to :author
  belongs_to :publisher
  belongs_to :category
end
