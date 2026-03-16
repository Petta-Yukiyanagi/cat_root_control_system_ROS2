import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    # パッケージ共有ディレクトリ内の rviz 設定ファイルを取得
    pkg_share = get_package_share_directory('cat_robot_bringup')
    rviz_config_path = os.path.join(pkg_share, 'rviz', 'slam.rviz')

    return LaunchDescription([
        # 設定ファイルを指定して RViz2 を起動
        Node(
            package='rviz2',
            executable='rviz2',
            name='rviz2',
            arguments=['-d', rviz_config_path],
            output='screen'
        )
    ])