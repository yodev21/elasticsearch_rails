# elasticsearch-rails運用
# https://qiita.com/chase0213/items/381b1eeacb849d93ecfd
# ニュース検索用モジュール
module BookSearch
  module Engine
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model

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

    def as_indexed_json(options={})
      # binding.irb
      book_attrs = {
        id: self.id,
        title: self.title,
        content: self.content
      }
      book_attrs[:users] = { email: user.email }
      book_attrs.as_json
    end

    class_methods do
      # ④indexを作成するメソッド
      def create_index!
        client = __elasticsearch__.client
        # すでにindexを作成済みの場合は削除する
        client.indices.delete index: self.index_name rescue nil
        # indexを作成する
        client.indices.create(index: self.index_name,
          body: {
            settings: self.settings.to_hash,
            mappings: self.mappings.to_hash
          })
      end
    end
  end
end