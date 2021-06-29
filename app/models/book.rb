class Book < ApplicationRecord
  belongs_to :user
  include Elasticsearch::Model

  # Book.__elasticsearch__.create_index! force: true
  # Book.import
  # Book.__elasticsearch__.import
  # Book.__elasticsearch__.index_name
  # Book.__elasticsearch__.document_type

  def as_indexed_json(options={})
    # カテゴリについて
    books_attrs = {
      id: self.id,
      name: self.title,
    }

    # カテゴリに紐づく記事について
    exit
    books_attrs[:user] = self.user.map do |user|
      {
        title: user.emaiil,
      }
    end

    books_attrs.as_json
  end
end
