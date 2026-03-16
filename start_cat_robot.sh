#!/bin/bash
PROJECT_DIR=$(cd $(dirname $0); pwd)
WORKSPACE_DIR=~/ws

echo "=== Cat Robot Integrated Starter ==="

# --- 追加：時刻同期（WSLの時計がズレている場合への対策） ---
echo "Time: Syncing system clock..."
# Windowsの時計に合わせる（WSL特有のコマンド）
sudo hwclock -s
# もしインターネット経由で厳密に合わせたいなら以下（要ntpdate）
# sudo ntpdate -u ntp.nict.jp

# 1. 通信設定
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file://"$PROJECT_DIR/cyclonedds.xml"

# 2. ワークスペースへのリンク確認
mkdir -p "$WORKSPACE_DIR/src"
if [ ! -L "$WORKSPACE_DIR/src/cat_robot" ]; then
    ln -snf "$PROJECT_DIR/src" "$WORKSPACE_DIR/src/cat_robot"
    echo "Info: Created symbolic link to workspace."
fi

# 3. ビルドと環境ロード
source /opt/ros/humble/setup.bash
if [ ! -f "$WORKSPACE_DIR/install/setup.bash" ]; then
    echo "Info: First build or build missing. Building now..."
    cd "$WORKSPACE_DIR" && colcon build --symlink-install
fi
source "$WORKSPACE_DIR/install/setup.bash"

# 4. GUI & 通信リセット
export LIBGL_ALWAYS_SOFTWARE=1
export MESA_GL_VERSION_OVERRIDE=3.3
ros2 daemon stop > /dev/null 2>&1
ros2 daemon start

# 5. 起動
echo "Launching system from: $PROJECT_DIR"
ros2 launch cat_robot_bringup system.launch.py
