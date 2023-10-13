# cotomemory

## 概要
cotomemoryというサービスは
時が経つにつれて、子どもの可愛い名言を忘れてしまうという問題 を解決したい、
子育て中の方向けの記録サービスです。

ユーザーは子供の名言を記録することができ、
スプレッドシートでまとめるのとは違って
スマホからシンプルに入力できる機能が備わっている事が特徴です。

## URL
```
https://cotomemory.com/
```

## 開発環境
Ruby 3.2.2
Ruby on Rails 7.0.5
Hotwire

## 開発環境立ち上げ
```
$ git clone https://github.com/siroemk/cotomemory.git
$ cd cotomemory
$ bin/setup

$ bin/dev
```

## 環境変数

| 環境変数名 | 説明 |
|---|---|
| GOOGLE_CLIENT_ID | GoogleクライアントID |
| GOOGLE_CLIENT_SECRET | Googleクライアント シークレット |

## Lint/Test
### Lint
```
$ rubocop
```

### Test
```
$ bundle exec rspec
```
