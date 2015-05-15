## 起動に必要な条件

 - MySQL
    - Host: localhost
    - User: dev\_master@localhost
    - Password: 空欄
    - Database: intern\_diary
 - Perl 5.18.2
 - Carton


## セットアップ

```
$ carton install
```

## CLI

### $ diary.pl add [title]
日記に記事を書きます。
### $ diary.pl list
日記に投稿された記事の一覧を表示します。
### $ diary.pl show [entry ID]
日記に投稿された記事の詳細を表示します。
### $ diary.pl show [entry ID]
日記に投稿された記事の詳細を表示します。
### $ diary.pl edit [entry ID]
指定したIDの記事を編集します。
### $ diary.pl delete [entry ID]
指定したIDの記事を削除します

<!--
## サーバ起動
以下のコマンドでサーバが起動できる。デフォルトではhttp://localhost:3000/ にアクセスすれば良い。
```
$ script/appup
```

## API

### $c
- `Intern::Diary::Context`
- コンテキストという名が示すように、ユーザーからのリクエストにレスポンスを返すまでに最低限必要な一連のメソッドがまとめられている

### $c->req
- リクエストオブジェクトを取得する
- [Plack::Request](http://search.cpan.org/~miyagawa/Plack/lib/Plack/Request.pm)を継承した`Intern::Diary::Request`

### $c->req->parameters->{key}
- `key`に対応するリクエストパラメーターを取得する
- クエリパラメーターやルーティングによって得られたパラメーターなど全てが対象となる

### $c->dbh
- データベースハンドラーを取得する
- [DBIx::Sunny](http://search.cpan.org/~kazeburo/DBIx-Sunny-0.22/lib/DBIx/Sunny.pm)を継承した`Intern::Diary::DBI`

### $c->html
- ファイル名とテンプレート変数を渡すと、レスポンスをHTMLとして設定してくれる
```perl
$c->html('index.html', { foo => $bar });
```

### $c->json
- ハッシュリファレンスを渡すと、レスポンスをJSONとして設定してくれる
```perl
$c->json({ spam => $egg });
```

### $c->redirect
- URLを渡すと、レスポンスをリダイレクトとして設定してくれる
```perl
$c->redirect('/');
```

### $c->res
- レスポンスオブジェクトを取得する
- [Plack::Response](http://search.cpan.org/~miyagawa/Plack-1.0030/lib/Plack/Response.pm)

### $c->route
- ルーティング結果が格納されたハッシュリファレンスを取得する
- ルーティングは`Intern::Diary::Config::Route`で行われる
-->
