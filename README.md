# 笑顔をみまもるアプリ「エミル」

[![Product Name](https://raw.github.com/GabLeRoux/WebMole/master/ressources/WebMole_Youtube_Video.png)](https://www.youtube.com/channel/UC4PtjOfZTbVp9DwtJv82Lzg)

## 製品概要
### Smile Tech

### 背景（製品開発のきっかけ、課題等）
小学生の子どもを持つ親は、子どもが学校で元気に過ごせているのか不安です。
学校は楽しいだろうか？登下校は安全だろうか？などなど、目の届かないところにいる子どもはとにかく心配でたまりません。

最近ではスマートフォンを持ってきてもよいとする小学校も増え、小学生もスマートフォンを持ち歩く時代になりました。
スマートフォンの機能を駆使すれば、子どもの動向を常に確認することも可能です。しかし、それでは子どもは監視されているようであまりいい気持ちはしないでしょう。

どうすれば子どものプライバシーを守りつつ、親に安心を届けられるのだろうか？その答えとして考えられたのが「エミル」です。

「エミル」が収集・通知する情報は、「子どもがいつ、どれだけ笑ったか」のみ。
子どもが笑っているということは、子どもが過ごす場所が安全で楽しい空間であることの証明になります。親にとってこれほど安心できることはないでしょう。
一方で子どもは、どこで何をしているのかを親に監視されることはありませんから、のびのびといつも通りの生活を楽しむことができます。

日常でついついあふれ出る笑顔をHackし、子ども自身だけでなく親も幸せになれる「Smile Tech」をこのアプリで実現します。

### 製品説明（具体的な製品の説明）
「エミル」は送信用アプリと確認用アプリの2つで構成されます。
また、各種データはアプリサーバによって処理、蓄積されます。

#### 送信用アプリ
送信用アプリは子どものスマートフォンにインストールして使用します。
起動後はバックグラウンドで常駐し、マイクから取得した音声データをアプリサーバに送信します。

#### アプリサーバ
アプリサーバでは送信用アプリから受け取った音声データを物音認識APIに受け渡します。
物音認識APIでは送られてきた音声データが笑い声のパターンとマッチングするかを判定し、マッチする場合はアプリサーバに通知を送ります。
物音認識APIから送られてきた通知をもとに、アプリサーバのデータベースに情報を蓄積します。

#### 確認用アプリ
確認用アプリは親のスマートフォンにインストールします。アプリサーバに蓄積された情報をもとに子どもの笑顔の情報を確認することができます。
このアプリでは、子どもがどれだけ笑ったかを「スマイレージ（Smileage）」というポイントで表わします。
子どもが笑うたびにどんどんたまっていくスマイレージによって、親に安心をもたらします。

##### グラフ画面
グラフ画面では、1日ごとのスマイレージとこれまでの積算スマイレージを表示します。
今日どれだけ笑ったのか、どの日に楽しいことがたくさんあったのかをグラフで確認することができます。

##### ヒートマップ画面
ヒートマップ画面では、1週間分のスマイレージを時間割の時間に分けてヒートマップで表示します。
どの授業で楽しいことがあったのかなどを確認することで、帰宅後の話題作りや子どもの興味関心を知るために活用できます。

##### クーポン画面
子どもの笑顔でスマイレージがたまるとともに、親としてもうれしい気持ちや安心感で満たされるはずです。
毎日元気に過ごしてくれる子どもへの恩返し、あるいはご褒美に、何か特別なことをしてあげましょう。
たとえば、「5000スマイレージたまったら晩ごはんはから揚げ！」など、使い道は家庭内で自由に決めることができます。

### 特長

#### 1. 特長1

#### 2. 特長2

#### 3. 特長3

### 解決出来ること
この製品を利用することによって最終的に解決できることについて記載をしてください。

### 今後の展望
今回は実現できなかったが、今後改善すること、どのように展開していくことが可能かについて記載をしてください。


## 開発内容・開発技術
### 活用した技術
#### API・データ
今回スポンサーから提供されたAPI、製品などの外部技術があれば記述をして下さい。

* 物音認識API
* 
* 

#### フレームワーク・ライブラリ・モジュール
* 
* 

#### デバイス
* iPhone 
* 

### 研究内容・事前開発プロダクト（任意）
ご自身やチームの研究内容や、事前に持ち込みをしたプロダクトがある場合は、こちらに実績なども含め記載をして下さい。

* 
* 


### 独自開発技術（Hack Dayで開発したもの）
#### 2日間に開発した独自の機能・技術
* 独自で開発したものの内容をこちらに記載してください
* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）
