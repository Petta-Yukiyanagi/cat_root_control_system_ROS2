import os
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    map_config_path = os.path.expanduser('~/ws/src/cat_robot/cat_robot_bringup/maps/my_map')

    return LaunchDescription([
        # SLAM Toolbox だけを残す
        Node(
            package='slam_toolbox',
            executable='async_slam_toolbox_node',
            name='slam_toolbox',
            output='screen',
            parameters=[{
                'use_sim_time': False,
                'odom_frame': 'odom',
                'base_frame': 'base_footprint',
                'scan_topic': '/scan',
                'mode': 'mapping',
                'map_update_interval': 5.0,
                'max_laser_range': 12.0,
                'minimum_time_interval': 0.5,
                'transform_timeout': 1.0,
                'tf_buffer_duration': 30.0,
                'map_file_name': map_config_path,
                'map_save_full_path': map_config_path
            }]
        ),
        # ※ static_transform_publisher はラズパイ側で動いているので、ここでは削除！
    ])