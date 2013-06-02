概要
-----------
編集中のファイルから、
* インデントの幅はいくつか？
* タブ派か？スペース派か？


といった雰囲気を読んで合わせてくれる無宗教VIMプラグイン。


インストール
-----------
``` vim
NeoBundle 'git://github.com/t02uk/tabdetect.git'
```

動作
-----------
1. 編集中ファイルがスペース派とおもわれるとき設定
```
softtabstop
shiftwidth
expandtab
```


2. タブ派とおもわれるとき設定
```
noexpandtab
```
下記は触らない(判断できない)
```
shiftwidth
expandtab
````


設定
-----------
スペース幅の推論などでサンプリングに使用する行数
```
g:tabautodetect_minline = 50
```
