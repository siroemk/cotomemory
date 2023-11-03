# Cotomemory

![logo](https://github.com/siroemk/cotomemory/assets/31835314/b944cee5-1e63-4220-b460-65664c9c178a)

## 概要
Cotomemoryはこどもの名言を記録するサービスです。  
時が経つにつれて、こどもの可愛い名言も忘れてしまうという問題を解決します。

こどもの名言の登録フォームがシンプルなので、忙しい方でも簡単に記録することができます。  
また、家族を招待することでこども名言を共有することができます。

## URL
```
https://cotomemory.com/
```

## 使い方
### 1. Googleでログインする
<img width="30%" alt="ログイン画面" src="https://github.com/siroemk/cotomemory/assets/31835314/ea0b6a32-8169-4adf-a0c3-16ea25dd597f">

### 2. こどもの情報を登録する
<img width="30%" alt="こどもの登録画面" src="https://github.com/siroemk/cotomemory/assets/31835314/05666015-9f38-4b22-ae3c-2c3fe2736f69">

### 3. こどもの名言を登録する
<img width="30%" alt="名言画面" src="https://github.com/siroemk/cotomemory/assets/31835314/18a94d51-7556-4ac5-8933-33de162b3650">

## 招待機能の使い方
### 1. 招待する側の人が招待URLを取得する
<img width="30%" alt="招待画面" src="https://github.com/siroemk/cotomemory/assets/31835314/101811ad-d086-4aeb-b5d9-18bf681e1443">

ログイン後にメニューの「家族を招待する」にアクセスすると招待URLが表示されます。  
このURLを招待したい家族に伝えてください。

### 2. 招待された側の人は招待URLからログインする
<img width="30%" alt="welcomeページ" src="https://github.com/siroemk/cotomemory/assets/31835314/9398e50f-39bc-4703-9fa7-dee028633973">

招待された人は招待URLにアクセスし、表示された画面からGoogleでログインしてください。  
招待URLからログインすると、家族が登録した名言も名言一覧に表示されるようになります。

## 開発環境
- Ruby 3.2.2
- Ruby on Rails 7.0.5
- Hotwire

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
