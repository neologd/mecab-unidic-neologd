# mecab-unidic-NEologd : Neologism dictionary for unidic-mecab

## 詳細な情報
mecab-unidic-neologd に関する詳細な情報(サンプルコードなど)は以下の Wiki に書いてあります。

- https://github.com/neologd/mecab-unidic-neologd/wiki/Home.ja

## mecab-unidic-neologd とは
mecab-unidic-neologd は、UniDic に多数のWeb上の言語資源から得た新語や固有表現、絵文字などのエントリを足して MeCab のシステム辞書としてインストールするためのシードデータとスクリプト群のセットです。

シードデータの性質上、構築されるシステム辞書には国語研短単位の条件を満たさないエントリも入ります。

あらかじめご了承ください。

UniDic を使用してテキストデータから特徴ベクトルを生成する際や、UniDic を使用してテキストマイニングをする際には、 UniDic と mecab-unidic-NEologd を併用すると便利です。

## 特徴
### 利点
- UniDic には含まれていない固有表現などの語の表層(表記)とフリガナの組を約258万組(重複エントリを含む)採録しています
- この辞書の更新は開発サーバ上で自動的におこなわれます
    - 少なくとも毎週 2 回更新される予定です
            - 月曜日と木曜日
- Web上の言語資源を活用しているので、更新時に新しい固有表現を採録できます
    - 現在使用している資源は以下のとおりです
        - [はてなキーワードのダンプデータ](http://developer.hatena.ne.jp/ja/documents/keyword/misc/catalog)
        - [郵便番号データダウンロード](http://www.post.japanpost.jp/zipcode/download.html)
        - [日本全国駅名一覧のコーナー](http://www5a.biglobe.ne.jp/~harako/data/station.htm)
        - [人名(姓/名)エントリデータ](http://togetter.com/li/111529)
        - Unicode 6.0 以下の絵文字に手作業で読み仮名を付与したデータ
        - Web からクロールした大量の文書データ
    - 今後も他の新たな言語資源から抽出した固有表現などの語を採録する予定です

### 欠点
- 国語研短単位の条件を満たさないエントリも入る
- 固有表現の分類が不十分です
    - 例えば一部の人名と製品名が同じ固有表現カテゴリに分類されています
- 固有表現では無い語も固有表現として登録されています
- 固有表現の表記とフリガナの対応づけを間違っている場合があります
    - すべての固有表現とフリガナの組に対する人手による検査を実施していないためです
- Web上の資源が更新されないなら、新しい固有表現は辞書に追加されません
- 対応している文字コードは UTF-8 のみです
    - インストール済みの MeCab が使用している unidic が UTF-8 版である必要があります

## 使用開始
### 動作に必要なもの

インストール時に mecab-unidic をベースにビルド処理をするために必要なライブラリがあります。

apt、yum や homebrew でインストールするか、自前でコンパイルしてインストールして下さい。

- C++ コンパイラ
    - GCC-4.4.7 と Apple LLVM version 6.0 で動作を確認しています
- iconv (libiconv)
    - 辞書のコード変換に使います
- mecab
    - MeCab 本体です
    - bin/mecab と bin/mecab-config を使います
- mecab-unidic
    - MeCab 用の辞書のひとつです
        - インストール時のテストに使います
        - ソースコードからインストールするときは以下の手順で文字コードを UTF-8 インストールして下さい

    cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

または

    ./configure; make; sudo make install

- xz
    - mecab-unidic-neologd のシードの解凍に unxz を使います

他にも足りないものがあったら適時インストールして下さい。

#### 例
- CentOS の場合

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ sudo yum install mecab git make curl xz

- Fedora の場合

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ sudo yum install mecab mecab-devel git make curl xz

- Ubuntu の場合

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ sudo aptitude install mecab libmecab-dev git make curl xz-utils

- Mac OSX の場合

    $ brew install mecab mecab-unidic git curl xz

### mecab-unidic-neologd をインストールする準備

辞書の元になるデータの配布と更新は GitHub 経由で行います。

初回は以下のコマンドでgit cloneしてください。

    $ git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd.git

または

    $ git clone --depth 1 git@github.com:neologd/mecab-unidic-neologd.git

もしも、リポジトリの全変更履歴を入手したい方は「--depth 1」を消してcloneして下さい。

全変更履歴のデータサイズは変動しますが、ピーク時は約 1GB となり、かなり大容量ですのでご注意下さい。

### mecab-unidic-neologd のインストール/更新
#### Step.1
上記の準備でcloneしたリポジトリに移動します。

    $ cd mecab-unidic-neologd

#### Step.2
以下のコマンドを実行するとインストール、または、上書きによる最新版への更新ができます。

    $ ./bin/install-mecab-unidic-neologd -n

インストール先はオプション未指定の場合 mecab-config に従って決まります。

以下のコマンドを実行すると確認できます。

    $ echo `mecab-config --dicdir`"/mecab-unidic-neologd"

複数の MeCab をインストールしている場合は、任意の mecab-config にパスを通して下さい。

任意の path にインストールしたい場合や、user 権限でインストールする際のオプションなどは以下で確認できます。

    $ ./bin/install-mecab-unidic-neologd -h

### mecab-unidic-neologd の使用方法
mecab-unidic-neologd を使いたいときは、MeCab の -d オプションにカスタムシステム辞書のパス(例: */lib/mecab/dic/mecab-unidic-neologd/)を指定してください。

#### 例 (CentOS 上でインストールした場合)

    $ mecab -d /usr/local/lib/mecab/dic/mecab-unidic-neologd/

## MeCabの実行結果の例
### mecab-unidic-neologd をシステム辞書として使った場合
    $echo "10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。" | mecab -d /usr/local/lib/mecab/dic/mecab-unidic-neologd
    10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。
    1       イチ    イチ    一      名詞-数詞
    0       ゼロ    ゼロ    ゼロ-zero       名詞-数詞
    日      カ      カ      日      接尾辞-名詞的-助数詞
    放送    ホーソー        ホウソウ        放送    名詞-普通名詞-サ変可能
    の      ノ      ノ      の      助詞-格助詞
    「                      「      補助記号-括弧開
    中居正広のミになる図書館        ナカイマサヒロノミニナルトショカン      ナカイマサヒロノミニナルトショカン      中居正広のミになる図書館        名詞-固有名詞-一般
    」                      」      補助記号-括弧閉
    （                      （      補助記号-括弧開
    テレビ朝日      テレビアサヒ    テレビアサヒ    テレビ朝日      名詞-固有名詞-一般
    系      ケー    ケイ    系      接尾辞-名詞的-一般
    ）                      ）      補助記号-括弧閉
    で      デ      デ      で      助詞-格助詞
    、                      、      補助記号-読点
    SMAP    スマップ        スマップ        SMAP    名詞-固有名詞-一般
    の      ノ      ノ      の      助詞-格助詞
    中居正広        ナカイマサヒロ  ナカイマサヒロ  中居正広        名詞-固有名詞-人名-一般
    が      ガ      ガ      が      助詞-接続助詞
    、                      、      補助記号-読点
    篠原信一        シノハラシンイチ        シノハラシンイチ        篠原信一        名詞-固有名詞-人名-一般
    の      ノ      ノ      の      助詞-格助詞
    過去    カコ    カコ    過去    名詞-普通名詞-副詞可能
    の      ノ      ノ      の      助詞-格助詞
    勘違い  カンチガイ      カンチガイ      勘違い  名詞-普通名詞-サ変可能
    を      オ      ヲ      を      助詞-格助詞
    明かす  アカス  アカス  明かす  動詞-一般       五段-サ行       連体形-一般
    一幕    ヒトマク        ヒトマク        一幕    名詞-普通名詞-一般
    が      ガ      ガ      が      助詞-格助詞
    あっ    アッ    アル    有る    動詞-非自立可能 五段-ラ行       連用形-促音便
    た      タ      タ      た      助動詞  助動詞-タ       終止形-一般
    。                      。      補助記号-句点
    EOS

#### どこに効果が出ている?
- Mecab は mecab-unidic-neologd に収録された語をひとつの語として分割しました
    - 「中居正広のミになる図書館」は2011年後半に生まれた新しい語です
        - この語はWeb上の言語資源が更新されたのでひとつの語として分割されました
- mecab-unidic-neologd に収録されているほとんどの語にフリガナが付いています

### unidic-mecab 2.1.2 を使った場合
    $echo "10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。" | mecab -d /usr/local/lib/mecab/dic/unidic
    10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。
    1       イチ    イチ    一      名詞-数詞
    0       ゼロ    ゼロ    ゼロ-zero       名詞-数詞
    日      カ      カ      日      接尾辞-名詞的-助数詞
    放送    ホーソー        ホウソウ        放送    名詞-普通名詞-サ変可能
    の      ノ      ノ      の      助詞-格助詞
    「                      「      補助記号-括弧開
    中居    ナカイ  ナカイ  ナカイ  名詞-固有名詞-人名-姓
    正広    マサヒロ        マサヒロ        マサヒロ        名詞-固有名詞-人名-名
    の      ノ      ノ      の      助詞-格助詞
    ミ      ミ      ミ      ミ      記号-一般
    に      ニ      ニ      に      助詞-格助詞
    なる    ナル    ナル    成る    動詞-非自立可能 五段-ラ行       連体形-一般
    図書    トショ  トショ  図書    名詞-普通名詞-一般
    館      カン    カン    館      接尾辞-名詞的-一般
    」                      」      補助記号-括弧閉
    （                      （      補助記号-括弧開
    テレビ  テレビ  テレビ  テレビ-television       名詞-普通名詞-一般
    朝日    アサヒ  アサヒ  朝日    名詞-普通名詞-一般
    系      ケー    ケイ    系      接尾辞-名詞的-一般
    ）                      ）      補助記号-括弧閉
    で      デ      デ      で      助詞-格助詞
    、                      、      補助記号-読点
    S       エス    エス    Ｓ      記号-文字
    M       エム    エム    Ｍ      記号-文字
    A       エー    エー    Ａ      記号-文字
    P       ピー    ピー    Ｐ      記号-文字
    の      ノ      ノ      の      助詞-格助詞
    中居    ナカイ  ナカイ  ナカイ  名詞-固有名詞-人名-姓
    正広    マサヒロ        マサヒロ        マサヒロ        名詞-固有名詞-人名-名
    が      ガ      ガ      が      助詞-格助詞
    、                      、      補助記号-読点
    篠原    シノハラ        シノハラ        シノハラ        名詞-固有名詞-人名-姓
    信一    シンイチ        シンイチ        シンイチ        名詞-固有名詞-人名-名
    の      ノ      ノ      の      助詞-格助詞
    過去    カコ    カコ    過去    名詞-普通名詞-副詞可能
    の      ノ      ノ      の      助詞-格助詞
    勘違い  カンチガイ      カンチガイ      勘違い  名詞-普通名詞-サ変可能
    を      オ      ヲ      を      助詞-格助詞
    明かす  アカス  アカス  明かす  動詞-一般       五段-サ行       連体形-一般
    一幕    ヒトマク        ヒトマク        一幕    名詞-普通名詞-一般
    が      ガ      ガ      が      助詞-格助詞
    あっ    アッ    アル    有る    動詞-非自立可能 五段-ラ行       連用形-促音便
    た      タ      タ      た      助動詞  助動詞-タ       終止形-一般
    。                      。      補助記号-句点
    EOS

## 研究結果の評価や再現などに使いたい場合
以下に更新を止めた辞書をリリースしています。

- https://github.com/neologd/mecab-unidic-neologd/releases/

以下の用途でご利用いただく場合は便利でしょう。

- 研究結果の評価実験
- 他人の研究結果の再現
- 永遠に更新しない形態素解析結果の作成

言語処理を始めたばかりの方や上記以外の多くの用途には master branch の最新版の使用を推奨します。

## 今後の発展
継続して開発しますので、気になるところはどんどん改善されます。

ユーザの8割が気になる部分を優先して改善します。

## Bibtex

もしも mecab-unidic-NEologd を論文から参照して下さる場合は、以下の bibtex をご利用ください。

    @misc{sato2015mecabunidicneologd,
        title  = {Neologism dictionary based on the language resources on the Web for unidic-mecab},
        author = {Toshinori, Sato},
        url    = {https://github.com/neologd/mecab-unidic-neologd},
        year   = {2015}
    }

## Copyrights
Copyright (c) 2015-2016 Toshinori Sato (@overlast) All rights reserved.

ライセンスは Apache License, Version 2.0 です。下記をご参照下さい。

- https://github.com/neologd/mecab-unidic-neologd/blob/master/COPYING
