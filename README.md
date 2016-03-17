# はじめに
* [Bitbar](https://github.com/matryer/bitbar
)を使って`Makuake`,`camp-fire`,`readyfor`といった日本のクラウドファンディングの任意のプロジェクトの経過を簡単に把握するためのプラグインになります
* 支援をしてからそのプロジェクトの進捗を簡単に確認する為のツールになります

# 設定
## BitBarインストール
手っ取り早くhomebrewを使う

```
brew cask install bitbar
```
詳しくは下記
https://github.com/matryer/bitbar


## ソースを任意の場所にclone
* example
```
mkdir /Users/a12091/bitbar
```
homeディレクトリに`bitbar`ディレクトリを作成してそのディレクトリにclone

## 初期設定
* tmpディレクトリを作成
```
mkdir /Users/a12091/bitbar/tmp
```

* config設定
```
/Users/a12091/bitbar/config/watcher.yml
```
watchしたいurlをyaml形式で記載

* MAINPATH設定
```
/Users/a12091/bitbar/cf_watcher.20m.sh
3行目
3 MAINPATH='/Users/a12091/bitbar'
```
cloneしたパスを記載


## BitBarの設定
1. BitBarを起動
1. BitBarのPreference > Opne Plugin Folder
1. `/Users/a12091/bitbar`を選択


# 見方
```
[達成率(%)][集まってる金額][プロジェクトのタイトル名]
```

