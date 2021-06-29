class Manga < ApplicationRecord
  include MangaSearch::Engine

  belongs_to :author
  belongs_to :publisher
  belongs_to :category
  
  include Elasticsearch::Model
  # def search
  #   exit
  # end
  # query = {
  #   "bool": {
  #     "should": [
  #       {
  #         "match": {
  #           "name": "清水茜"
  #         }
  #       },
  #       {
  #         "nested": {
  #           "path": "author",
  #           "query": {
  #             "match": {
  #               "author.name": "清水茜"
  #             }
  #           }
  #         }
  #       }
  #     ]
  #   }
  # }
  # book = Book.search(query)
end
