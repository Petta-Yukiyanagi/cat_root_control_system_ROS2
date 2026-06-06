import os
# パッケージのパスを動的に取得するための関数をインポート
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    # 1. cat_robot_bringup パッケージのインストール先（shareディレクトリ）のパスを自動取得
    pkg_share = get_package_share_directory('cat_robot_bringup')
    
    # 2. パッケージのパスを起点に、各ファイルへのパスを結合する（これがROS2の相対パス指定）
    slam_config_path = os.path.join(pkg_share, 'config', 'slam_toolbox_config.yaml')
    map_config_path = os.path.join(pkg_share, 'maps', 'my_map')

    return LaunchDescription([
        # SLAM Toolbox
        Node(
            package='slam_toolbox',
            executable='async_slam_toolbox_node',
            name='slam_toolbox',
            output='screen',
            parameters=[
                slam_config_path,  # 自動取得したパスで読み込み
                {
                    'map_file_name': map_config_path,
                    'map_save_full_path': map_config_path
                }
            ]
        ),
    ])