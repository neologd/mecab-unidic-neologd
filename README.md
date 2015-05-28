# mecab-unidic-NEologd : Neologism dictionary for MeCab

## For Japanese
README.ja.md is written in Japanese.

- https://github.com/neologd/mecab-unidic-neologd/blob/master/README.ja.md

## Documentation
You can find more detailed documentation and examples in the following wiki.

- https://github.com/neologd/mecab-unidic-neologd/wiki/Home

## Overview
mecab-unidic-neologd is customized system dictionary for MeCab.

This dictionary includes many neologisms (new word), which are extracted from many language resources on the Web.

When you analyze the Web documents, it's better to use this system dictionary and default UniDic together.

## Pros and Cons
### Pros
- Recorded about 1.67 million pairs(including duplicate entries) of surface/furigana(kana indicating the pronunciation of kanji) of the words such as the named entity that can not be tokenized correctly using default system dictionary of MeCab.
- Update process of this dictionary will automatically run on development server.
    - I'm planning to renew this dictionary in monthly beginning of the month and middle of the month.
- When renewing by utilizing the language resources on Web, a new named entity can be recorded.
    - The resources are being utilized at present are as follows.
        - Dump data of hatena keyword
        - Japanese postal code number data download (ken_all.lzh)
        - The name-of-the-station list of the Japan whole country
        - The entry data of the person name (last name / first name)
        - All manually annotated entry data for Unicode emoji
        - A lot of documents, which crawled from Web
    - I'm planning to record the words such as the named entity, which will be extracted from other new language resource.

### Cons
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

    ./configure --with-charset=utf8; make; sudo make install

- xz
    - Use to decompress a xz package of a seed of mecab-unidic-neologd

Please install at any time other lack library.

#### Examples
- On CentOS

    $ cd mecab-unidic-neologd
    $ sudo ./libexec/install-mecab-unidic.sh
    $ sudo yum install mecab mecab-unidic git make curl xz

- On Fedora

    $ cd mecab-unidic-neologd
    $ sudo ./libexec/install-mecab-unidic.sh
    $ sudo yum install mecab mecab-devel mecab-unidic git make curl xz

- On Ubuntu

    $ cd mecab-unidic-neologd
    $ sudo ./libexec/install-mecab-unidic.sh
    $ sudo aptitude install mecab libmecab-dev mecab-unidic-utf8 git make curl xz-utils

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

#### What's the point of the above result

- MeCab can parse the words which are recorded in mecab-unidic-neologd correctly.
    - "中居正広のミになる図書館(Masahiro Nakai's library to improve an ability)" is a new word.
        - This word could parse correctly because of updating of the language resources on Web.
- Almost all of the entry of mecab-unidic-neologd has the value of furigana field.

### When you use default system dictionary
    $echo "10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。" | mecab

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
