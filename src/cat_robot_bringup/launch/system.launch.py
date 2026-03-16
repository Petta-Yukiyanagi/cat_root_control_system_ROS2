import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource

def generate_launch_description():
    # このパッケージのlaunchディレクトリを取得
    launch_dir = os.path.join(get_package_share_directory('cat_robot_bringup'), 'launch')

    # SLAMの起動設定
    slam_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(launch_dir, 'slam.launch.py'))
    )

    # RViz2の起動設定
    rviz_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(launch_dir, 'rviz.launch.py'))
    )

    bridge_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(launch_dir, 'bridge.launch.py'))
    )

    return LaunchDescription([
        slam_cmd,
        rviz_cmd,
        bridge_cmd

    ])