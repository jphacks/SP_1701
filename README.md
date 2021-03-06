# 笑顔をみまもるアプリ「エミル」

[![](http://img.youtube.com/vi/mUH5lNO9mks/0.jpg)](https://www.youtube.com/watch?v=mUH5lNO9mks)

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
![エミル](./emillogo.png)

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
この画面ではたまったスマイレージの使い道である「クーポン」の発行と編集、使用をすることができます。
たとえば、「5000スマイレージたまったら晩ごはんはから揚げ！」など、使い道は家庭内で自由に決めることができます。

### 特長

#### 1. 子どものプライバシーと親の安心の両立
従来の「みまもり」アプリは、どうしても子どもの行動を監視する方向に機能が実装されがちでした。
GPS情報、使用したアプリの履歴、接続したWi-Fiなどなど……そうしたログデータの取得は、しばしば子どもの自由な発想や楽しい時間を損ないます。
みまもりアプリがみまもりアプリとして効果を発揮し続けるためには、子どもがアプリを入れつづけてくれること、そしてアプリを入れることによる心理的負担が少ないことが大切になってきます。
「エミル」では音声データを取得しますが、親に通知されるのはそのうち「子どもがいつ、どれだけ笑ったか」のみです。
子どもがどこで何をしているのか具体的に知ることはできませんが、それでも「子どもが笑って過ごしている」という事実は親にこの上ない安心感を与えます。

#### 2. 笑顔の統計
「子どもがいつ、どれだけ笑ったか」というデータだけでも、さまざまな事実が見えてきます。
たとえば、ヒートマップ画面で確認できる「時間割ごとの笑顔の回数」のデータを、学校で配られた時間割表と組み合わせることで、子どもの興味のある教科、楽しいと思っている授業を推測することができます。
家に帰ってきたら、興味のありそうな話題で学校の話を聞いてみましょう。

#### 3. 笑顔を増やす
子どもにどれだけ楽しいことがあったのかを記録するだけが「エミル」ではありません。
子どもの笑顔とともにたまる「スマイレージ」を「クーポン」にすることで、積極的に笑顔を増やしていくことができます。

### 解決出来ること
「エミル」では、従来のみまもりアプリで問題となっていた「子どものプライバシー」を守りつつ、みまもりアプリに求められる「親の安心」を提供し、さらに従来のみまもりアプリではできなかった「子どもの関心を探る」ことを可能としています。

### 今後の展望
- 物音認識APIを用いた笑顔の認識の精度向上
- ユーザインタフェースの改善
- サーバとのデータ通信部分の改善

## 開発内容・開発技術
### 活用した技術
#### API・データなど
* 物音認識API
* 機械学習
* Django

#### 使用言語
* Swift
* Python

#### デバイス
* iPhone
* PC（音声認識、機械学習）

### 独自開発技術（Hack Dayで開発したもの）
#### 2日間に開発した独自の機能・技術
* 笑い声を認識するための独自の機械学習モデル構築
* ストーリーボードの作成とDjangoでの環境設定以外は全て二日間で実装しました（詳しくは「製品説明」で紹介しています）
