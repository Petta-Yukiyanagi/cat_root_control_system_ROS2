# cat_robot_repo

🐱 ROS 2 (Humble) をベースにした、猫型ロボット `cat_robot` の統合制御リポジトリです。
WSLg環境での動作に最適化されており、Tailscale経由でのリモート操作とWeb UIからのコマンド送信に対応しています。

## 📁 ディレクトリ構成
```
cat_robot_repo/
├── src/
│   ├── cat_robot_bringup/      システム全体の起動設定URDF
│   └── catui_msgs/             独自メッセージ定義                  
├── web_ui/                     ブラウザ操作用HTMLコントローラー
│   └── index.html              WebSocket制御画面
├── cyclonedds.xml              Tailscale環境用DDS設定
└── start_cat_robot.sh          時刻同期、ビルド確認、一括起動スクリプト
```


## 🚀 セットアップと起動方法

### 1. 前提条件
- OS: Ubuntu 22.04 (WSL2)
- ROS 2: Humble (Desktop)
- Network: Tailscale（リモート通信を行う場合）

### 2. インストール

```bash
cd ~/cat_robot_repo
chmod +x install.sh
./install.sh
```
### 3. 起動
次回以降は、このコマンドだけでシステムが立ち上がります。


```Bash
cd ~/cat_robot_repo
chmod +x start_cat_robot.sh
./start_cat_robot.sh
```
画面指定をする場合、下記を実行します。
```Bash
export DISPLAY=:0
```
DISPLAY値を確認する場合は、下記を実行します。

```Bash
echo $DISPLAY
```
### 4. 🎮 Webコントローラーの使用方法
web_ui/controller.html をブラウザで開きます。

接続先URLに、WSL側のTailscale IPを指定します（例: ws://100.xx.xx.xx:9090）。

「Connect」を押し、ステータスが Connected! になれば準備完了です。

十字キーでの移動操作や、UIコマンドの送信が可能です。

### 5. 🔧 通信設定について (CycloneDDS)
このプロジェクトは、Tailscale経由の不安定な通信を安定させるために CycloneDDS を採用しています。
設定は cyclonedds.xml に集約されており、特定のPeer（ラズパイ等）とのユニキャスト通信を前提としています。