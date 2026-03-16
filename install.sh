#!/bin/bash
set -e

echo "=== 1. システムアップデートと基本ツールの導入 ==="
sudo apt update && sudo apt upgrade -y
sudo apt install -y locales curl gnupg2 lsb-release build-essential git wget x11-apps

# ロケールの設定
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

echo "=== 2. ROS 2 Humble のインストール ==="
if [ ! -d "/opt/ros/humble" ]; then
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $VERSION_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    sudo apt update
    sudo apt install -y ros-humble-desktop ros-dev-tools
fi

echo "=== 3. 依存パッケージの導入 (SLAM, RViz, Rosbridge, DDS) ==="
sudo apt install -y \
    ros-humble-slam-toolbox \
    ros-humble-rosbridge-suite \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    python3-colcon-common-extensions

echo "=== 4. CycloneDDS設定ファイルの作成 ==="
# リポジトリ内のxmlを優先するため、ここではベースとなるパスに配置
cat << 'INNER_EOF' > ~/cyclonedds.xml
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config">
    <Domain id="any">
        <General>
            <Interfaces>
                <NetworkInterface name="tailscale0"/>
            </Interfaces>
        </General>
    </Domain>
</CycloneDDS>
INNER_EOF

echo "=== 5. ワークスペースの準備 ==="
mkdir -p ~/ws/src

echo "=== 6. .bashrc への環境設定の追加 ==="
if ! grep -q "CAT_ROBOT_ENV" ~/.bashrc; then
cat << 'INNER_EOF' >> ~/.bashrc

# --- CAT_ROBOT_ENV ---
source /opt/ros/humble/setup.bash
[ -f ~/ws/install/setup.bash ] && source ~/ws/install/setup.bash
export LIBGL_ALWAYS_SOFTWARE=1
export MESA_GL_VERSION_OVERRIDE=3.3
# --- END ---
INNER_EOF
fi

echo "=== セットアップ完了！ ==="
echo "次に ./start_cat_robot.sh を実行してシステムを起動してください。"