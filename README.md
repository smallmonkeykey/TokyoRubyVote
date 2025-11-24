# TokyuRubyVote
このアプリは、 TokyuRuby会議で一番良かったLT、一番美味しかった料理、一番美味しかったお酒を決めるための投票アプリです。<br>
このアプリを使うことで集計に手間がかかる問題を解決し、感想共有を伝えることができます。<br><br>
ユーザーは、良かったLT、料理、お酒にブラウザから感想と投票をすることができます。<br>
また、参加者自身が当日持ち寄った料理やお酒をその場で登録して立候補でき、自分の料理やお酒に対する感想をアプリを通じて受け取ることができます。

# ローカルセットアップ手順  

```
git clone してください
bundle install
bin/rails db:create
bin/rails db:migrate
bin/rails tailwindcss:build
bin/rails s
```

GitHubOAuthを利用しているため、開発者ごとにcredentialsの作成が必要です。
1. ファイルは各自の環境で生成してください
config/credentials/development.yml.enc
config/credentials/development.key

2. GitHubでOAuthAppを作成
設定する値：
Homepage URL:
http://localhost:3000

Authorization callback URL:
http://localhost:3000/auth/github/callback

ここで発行されるClientIDとClientSecretを控えておきます。

3. RailsのcredentialsにGitHub情報を記載してください
```
bin/rails credentials:edit --environment development
```
下記のように記述します：
```
github:
  client_id: あなたのClientID
  client_secret: あなたのClientSecret
```

# Lint
Rubyのlint
```
bundle exec rubocop
```
ERBのlint
```
bundle exec erblint .
```
