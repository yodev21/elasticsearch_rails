class Book < ApplicationRecord
  include BookSearch::Engine
  include Elasticsearch::Model

  belongs_to :user
  # Book.__elasticsearch__.create_index! force: true
  # Book.import
  # Book.__elasticsearch__.import
  # Book.__elasticsearch__.index_name
  # Book.__elasticsearch__.document_type
end
