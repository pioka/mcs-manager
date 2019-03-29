# mcs-manager
Minecraftサーバ管理用DiscordBot

## つかいかた
### Minecraftサーバをダウンロード
```sh
$ cd game
$ ./getserver.sh

$ echo 'eula=true' > eula.txt
```

### Botを起動
```sh
$ cd bot 
$ go build
$ ./mcs-server-bot <BotToken> <ServerOwnerID>
```
`BotToken`は各自用意してください。  
`ServerOwnerID`に指定したIDのユーザのみがサーバの起動・停止を行えます。初回は適当な文字列を指定してpingコマンドで調べてください

### Bot呼び出し
Discordサーバにて
```
!mcs <COMMAND>
```
とチャットすることで呼び出せます。`COMMAND`には以下のコマンドを指定できます。

## コマンド
### ping
pongを返します。実行時のターミナルにはユーザのIDが表示されるので、前述した`ServerOwnerID`を調べるのに使えます。

### status
Minecraftサーバが起動中か停止中か返します。

### start
Minecraftサーバを起動します

### stop
Minecraftサーバを停止します。