# MyTwitterClone
Twitterっぽいアプリを作ってみました。

Rails Tutorialで勉強した内容を復習するために、ゼロから作り直したSNSアプリです。
ただ同じもの作るだけじゃつまらないので、リアルタイムDMとか画像投稿とか、自分なりの機能も追加してみました。

## できること

- ユーザー登録とログイン
- つぶやき投稿（画像もつけられる）
- 他のユーザーをフォロー
- タイムラインで自分とフォローしてる人の投稿を見る
- リアルタイムでDMのやりとり
- プロフィール画像の設定
- パスワードを忘れたときのリセット機能

## 使った技術

- Ruby on Rails 7
- SQLite
- Action Cable（リアルタイム通信）
- Active Storage（画像アップロード）
- Minitest（テスト書きました）

## 工夫したところ

- DMをAction Cableで非同期にして、ページリロードなしで送受信できるようにした
- UIをダークテーマにして、Twitterっぽい見た目にした
- テストを49個書いて、ちゃんと動くか確認した

## ローカルで動かす
```bash
git clone [このリポジトリのURL]
cd my-twitter-clone
bundle install
rails db:migrate

# 画像処理に必要（Ubuntu/WSL）
sudo apt install libvips libvips-dev

rails server
```

`http://localhost:3000` にアクセスすれば動きます。

## テスト
```bash
rails test
```

全部で49テスト、全部通ります。

## 作った理由

学生インターンの準備でRailsを勉強し直したくて作りました。
2週間くらいで完成させる予定だったけど、色々機能追加してたらもうちょっとかかりました。

コードの「なぜここでこうするのか」を理解しながら作ったので、いい復習になりました。