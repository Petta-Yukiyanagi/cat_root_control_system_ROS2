cmake_minimum_required(VERSION 3.8)
project(cat_robot_bringup)

# ament_cmake を検索
find_package(ament_cmake REQUIRED)

# 全てのフォルダを install/share/cat_robot_bringup/ へインストール
# これをしないと ros2 launch でファイルを読み込めない
install(DIRECTORY 
  launch
  rviz
  maps
  meshes
  DESTINATION share/${PROJECT_NAME}
)

# パッケージとして登録
ament_package()