# mecab-unidic-NEologd : Neologism dictionary for unidic-mecab

## For Japanese
README.ja.md is written in Japanese.

- https://github.com/neologd/mecab-unidic-neologd/blob/master/README.ja.md

## Documentation
You can find more detailed documentation and examples in the following wiki.

- https://github.com/neologd/mecab-unidic-neologd/wiki/Home

## Overview
mecab-unidic-neologd is a set of a seed data of system dictionary for adding entries to unidic-mecab and scripts to install the synthesized dictionary as a system dictionary of MeCab.

Due to the nature of the seed data of system dictionary, the synthesized dictionary includes entries that do not satisfy the condition of Short Unit Word of National Institute for Japanese Language and Linguistics.

We appreciate your understanding.

When you build a feature vector of text data using UniDic or do text mining using UniDic, it's better to use UniDic and mecab-unidic-NEologd together.

## Pros and Cons
### Pros
- Recorded about 1.75 million pairs(including duplicate entries) of surface/furigana(kana indicating the pronunciation of kanji) of the words such as the named entity that can not be tokenized correctly using default system dictionary of MeCab.
- Update process of this dictionary will automatically run on development server.
    - I'm planning to renew this dictionary in monthly beginning of the month and middle of the month.
- When renewing by utilizing the language resources on Web, a new named entity can be recorded.
    - The resources are being utilized at present are as follows.
        - [Dump data of hatena keyword](http://developer.hatena.ne.jp/ja/documents/keyword/misc/catalog)
        - [Japanese postal code number data download (ken_all.lzh)](http://www.post.japanpost.jp/zipcode/download.html)
        - [The name-of-the-station list of the Japan whole country](http://www5a.biglobe.ne.jp/~harako/data/station.htm)
        - [The entry data of the person name (last name / first name)](http://togetter.com/li/111529)
        - All manually annotated entry data for Unicode emoji
        - A lot of documents, which crawled from Web
    - I'm planning to record the words such as the named entity, which will be extracted from other new language resource.

### Cons
- Includes entries that do not satisfy the condition of Short Unit Word of National Institute for Japanese Language and Linguistics.
- Classification of the named entity is insufficient
    - Ex. Some person names and a product name are classified into the same named entity category.
- Not named entity word is recorded as named entity too.
- Since the manual checking to all the named entities can't conduct, it may have made a mistake in matching of surface of the named entity and furigana of the named entity.
- Unless the language resources on Web are updated, a new named entity won't add to the dictionary.
- Corresponding to only UTF-8
    - You should install the UTF-8 version of MeCab

## Getting started
### Dependencies

We build mecab-unidic-neologd using the source code of mecab-unidic at installing phase.

You should install following libraries using apt or yum, homebrew, source-code.

- C++ Compiler
    - Operation on GCC-4.4.7 and Apple LLVM version 6.0 are confirmed
- iconv (libiconv)
    - Use to convert the character code of UniDic
- mecab
    - We use bin/mecab and bin/mecab-config
- mecab-unidic
    - One of a dictionary of MeCab
        - Use to test at the time of installation
        - If you install it using source code, you should select the UTF-8 as a character code


    cd mecab-unidic-neologd
    sudo ./libexec/install-mecab-unidic.sh

or

    ./configure; make; sudo make install

- xz
    - Use to decompress a xz package of a seed of mecab-unidic-neologd

Please install at any time other lack library.

#### Examples
- On CentOS

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ sudo yum install mecab git make curl xz

- On Fedora

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ cd mecab-unidic-neologd

    $ sudo yum install mecab mecab-devel git make curl xz

- On Ubuntu

    $ cd mecab-unidic-neologd; sudo ./libexec/install-mecab-unidic.sh

    $ sudo aptitude install mecab libmecab-dev git make curl xz-utils

- On MacOSX

    $ brew install mecab mecab-unidic git curl xz

### Preparation of installing
A seed data of the dictionary will distribute via GitHub repository.

In first time, you should execute the following command to 'git clone'.

    $ git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd.git

OR

    $ git clone --depth 1 git@github.com:neologd/mecab-unidic-neologd.git

If you need all log of mecab-unidic-neologd.git, you should clone the repository without '--depth 1'

### How to install/update mecab-unidic-neologd
#### Step.1
Move to a directory of the repository which was cloned in the above preparation.

    $ cd mecab-unidic-neologd

#### Step.2

You can install or can update(overwritten) the recent mecab-unidic-neologd by following command.

    $ ./bin/install-mecab-unidic-neologd -n

You can check the directory path to install it.

    $ echo `mecab-config --dicdir`"/mecab-unidic-neologd"

If you installed some mecab-config, you should set the path of the mecab-config which you want to use.

If you use following command, you can check useful command line option.

    $ ./bin/install-mecab-unidic-neologd -h

### How to use mecab-unidic-neologd
When you want to use mecab-unidic-neologd, you should set the path of custom system dictionay(*/lib/mecab/dic/mecab-unidic-neologd/) as -d option of MeCab.

#### Example (on CentOS)
$ mecab -d /usr/local/lib/mecab/dic/mecab-unidic-neologd/

## Example of output of MeCab
### When you use mecab-unidic-neologd
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

#### What's the point of the above result

- MeCab parsed the words which are recorded in mecab-unidic-neologd as a sinble word.
    - "中居正広のミになる図書館(Masahiro Nakai's library to improve an ability)" is a new word.
        - This word parsed as a single word because of updating of the language resources on Web.
- Almost all of the entry of mecab-unidic-neologd has the value of furigana field.

### When you use unidic-mecab 2.1.2
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

## To evaluate or to reproduce a research result
We release the tag for mainly research purpose.

- https://github.com/neologd/mecab-unidic-neologd/releases/

It is very useful for the following applications.

- Experiments for evaluation of a research result
- Reproducibility of a experimental result of others
- Creation of the processing results of morphological analysis that doesn't update forever

If you are the beginner of NLP, I recommend that you use the latest version of master branch.

## Bibtex

Please use the following bibtex, when you refer mecab-unidic-NEologd from your papers.

    @misc{sato2015mecabunidicneologd,
        title  = {Neologism dictionary based on the language resources on the Web for unidic-mecab},
        author = {Toshinori, Sato},
        url    = {https://github.com/neologd/mecab-unidic-neologd},
        year   = {2015}
    }

## Copyrights
Copyright (c) 2015 Toshinori Sato (@overlast) All rights reserved.

We select the 'Apache License, Version 2.0'. Please check following link.

- https://github.com/neologd/mecab-unidic-neologd/blob/master/COPYING
