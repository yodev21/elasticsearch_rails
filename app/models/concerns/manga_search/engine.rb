# Rails6でElasticsearchのキーワード検索実装ハンズオン
# https://qiita.com/fuqda/items/d568aaf6b28f2d348b0f

module MangaSearch
  module Engine
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model

      # ①index名
      index_name "es_manga_#{Rails.env}"

      # ②mapping情報
      # settings do
      #   mappings dynamic: 'false' do
      #     indexes :id,          type: 'integer'
      #     indexes :publisher,   type: 'keyword'
      #     indexes :author,      type: 'keyword'
      #     indexes :category,    type: 'text', analyzer: 'kuromoji'
      #     indexes :title,       type: 'text', analyzer: 'kuromoji'
      #     indexes :description, type: 'text', analyzer: 'kuromoji'
      #   end
      # endsettings do
      settings do
        mappings dynamic: 'false' do
          indexes :id,          type: 'integer'
          indexes :publisher,   type: 'nested' do
            indexes :name,      type: 'keyword'
          end
          indexes :author,      type: 'nested' do
            indexes :name,      type: 'keyword'
          end
          indexes :category,    type: 'nested' do
            indexes :name,    type: 'text', analyzer: 'kuromoji'
          end
          indexes :title,       type: 'text', analyzer: 'kuromoji'
          indexes :description, type: 'text', analyzer: 'kuromoji'
        end
      end

      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      # def as_indexed_json(*)
        # attributes
        #   .symbolize_keys
        #   .slice(:id, :title, :description)
        #   .merge(publisher: publisher_name, author: author_name, category: category_name)
      # end
    end
    def as_indexed_json(options={})
      # カテゴリについて
      manga_attrs = {
        id: self.id,
        title: self.title,
        description: self.description,
      }

        # binding.irb
      # カテゴリに紐づく記事について
      manga_attrs[:author] = {
                                name: author.name,
                              }
      manga_attrs[:category] = {
                                name: category.name,
                              }
      manga_attrs[:publisher] = {
                                name: publisher.name,
                              }

      manga_attrs.as_json
    end

    def publisher_name
      publisher.name
    end

    def author_name
      author.name
    end

    def category_name
      category.name
    end

    def search(query)
      exit
      elasticsearch__.search({
        query: {
          multi_match: {
            fields: %w(publisher author category title description),
            type: 'cross_fields',
            query: query,
            operator: 'and'
          }
        }
      })
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