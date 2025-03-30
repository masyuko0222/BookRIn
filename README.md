# BookRIn
![logo](https://github.com/user-attachments/assets/24a78858-78a4-4349-84d8-41b32e312847)

**BookRIn**は、輪読会での記録や学びを気軽にメモできるサービスです。

参加メンバー全員で、リアルタイム共同編集できるのが特徴です📚

また、テンプレート機能により、主催者が毎回同じフォーマットを作成する手間を省けます ✨

## 注意点
- 本サービスは PCでの利用 を想定しています。モバイル端末からもアクセス可能ですが、レイアウトや挙動に不具合が発生する場合があります。
- 本サービスは、フィヨルドブートキャンプ（以下 FBC） の生徒向けに提供されています。

## できること
#### リアルタイム共同編集
![image](https://github.com/user-attachments/assets/ddcb05c4-41f1-4d31-9519-0a0237cbaf23)

ノートは、複数人でリアルタイムに共同編集できます✨
お互いの学びを共有して、学習をさらに深めましょう！

#### テンプレートの利用
![image](https://github.com/user-attachments/assets/39d1c352-400b-4b8e-968b-351f7bbbaf33)

テンプレート機能を使えば、ノートの準備もスムーズに！
毎回フォーマットを用意する手間がなくなります😄

#### 輪読会の参加
FBCで開催されている輪読会に参加することができます。

1. 気になる輪読会をクリック
![image](https://github.com/user-attachments/assets/b99c49ad-7762-4434-a805-4ab39d7e53ef)

  
2. 参加ボタンを押すだけ😄
![image](https://github.com/user-attachments/assets/9a35a79b-9332-4063-aea6-96ebabddd05a)

3. 参加中の輪読会は、一覧からいつでも確認できます！
![image](https://github.com/user-attachments/assets/7ea37e47-bcd2-4f31-977a-fbd86821c859)

## 開発者向け

#### 使用技術
- Ruby：3.4.2
- Ruby on Rails：7.2.2.1
- Hotwire(turbo-rails, stimulus-rails)
- React：18.3.1

#### セットアップ
```
$ git clone https://github.com/自分のアカウント名/BookRIn.git
$ cd Bookrin
$ ./bin/setup
```

#### 起動
```
$ ./bin/dev
```

上記を実行後、`http://localhost:3000`にアクセス。

#### テスト
テスト実行には**Websocketの起動**が必須になります。
1. Websocketサーバの起動
- 参考：https://github.com/yjs/y-websocket
```
$ HOST=localhost PORT=5678 npx y-websocket
```

2. テストの実行
```
$ rails test:all
```

3. Websocketサーバの終了
- Ctrl + C でWebsocketサーバを終了
- テスト実行ごとに、Websocketサーバ起動→終了を行ってください
