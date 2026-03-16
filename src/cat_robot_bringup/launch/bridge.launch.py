from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='rosbridge_server',
            executable='rosbridge_websocket',
            name='rosbridge_websocket',
            output='screen',
            parameters=[{
                'port': 9090,            # デフォルトポート
                'address': '0.0.0.0',    # 全てのネットワークインターフェースを許可
                'retry_startup_delay': 5.0
            }]
        )
    ])