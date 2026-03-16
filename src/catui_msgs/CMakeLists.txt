cmake_minimum_required(VERSION 3.8)
project(catui_msgs)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(builtin_interfaces REQUIRED)

# メッセージファイルの登録（パスとファイル名に注意）
rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/CatUICommand.msg"
  DEPENDENCIES builtin_interfaces
)

ament_package()