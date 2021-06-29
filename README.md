# 一覧

http://localhost:9200/my_index/\_mapping

# manga

http://localhost:9200/es_manga_development/\_mapping

[Elasticsearch]Nested なデータ構造を定義して検索・ソートする
https://qiita.com/unum_penguin/items/83b647d1aedab7b6331a

join datatype と nested datatype の比較
https://developers.o-uccino.com/entry/2018/12/17/142025

# 備考

```test.erb
        <td><%= manga.publishers.name %></td>
        <td><%= manga.categories.name %></td>
        <td><%= manga.authors.name %></td>
        <td><%= manga.title %></td>
        <td><%= manga.description %></td>
        <td><%= manga.author.name %></td>
```
