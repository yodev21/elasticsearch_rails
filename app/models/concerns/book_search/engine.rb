# elasticsearch-rails運用
# https://qiita.com/chase0213/items/381b1eeacb849d93ecfd
# ニュース検索用モジュール
module BooksSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name 'books_index'

    settings do
      mappings dynamic: 'false' do
        indexes :id, type: 'long'      # ID
        indexes :title, type: 'text'   # タイトル
        indexes :content, type: 'text'        # 本文
        indexes :users, type: 'nested' do
          indexes :email, type: 'text'  # メールアドレス
        end
      end
    end
  end
end