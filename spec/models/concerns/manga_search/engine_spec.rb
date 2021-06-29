require 'rails_helper'

RSpec.describe MangaSearch::Engine, elasticsearch: true, model_name: "manga" do
  describe 'Manga.search' do
    describe '検索ワードにマッチする漫画の検索' do
      let!(:manga_1) do
        create(:manga, title: 'キングダム', description: '時は紀元前―。いまだ一度も統一...')
      end
      let!(:manga_2) do
        create(:manga, title: '僕のヒーローアカデミア', description: '多くの人間が“個性という力を持つ...')
      end
      let!(:manga_3) do
        create(:manga, title: 'はたらく細胞', description: '人間1人あたりの細胞の数、およそ60兆個...')
      end

      # 作成したデータをelasticsearchに登録する
      # refresh: true を追加することで登録したデータをすぐに検索できるようにする
      before { Manga.__elasticsearch__.import(refresh: true) }

      subject { Manga.search(query).records.pluck(:id) }

      context '検索ワードがタイトルにマッチする場合' do
        let(:query) { 'キングダム' }

        it '検索ワードにマッチする漫画を取得する' do
          is_expected.to include manga_1.id
        end
      end

      context '検索ワードが複数ある場合' do
        let(:query) { '人間 個性' }

        it '両方の検索ワードにマッチする漫画を取得する' do
          is_expected.to include manga_2.id
        end
      end

      context '検索ワードが本文にマッチする場合' do
        let(:query) { '60兆個' }

        it '検索ワードにマッチする漫画を取得する' do
          is_expected.to include manga_3.id
        end
      end
    end
  end
end