FactoryBot.define do
  factory :category do
    name { %w(ラブコメ ファンタジー サスペンス バトル スポーツ サイコスリラー 日常系).sample }
  end
end