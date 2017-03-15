# CMakeの最低バージョンを記述
cmake_minimum_required(VERSION 2.8)
# ソリューション名を指定
project(SampleSolution)

# OpenCVのパッケージを探す
# find_package(OpenCV REQUIRED)
# message("OPENCV ${OpenCV_VERSION} FOUND")

# インクルードパスを指定
include_directories()

# 実行ファイル名とソース指定
add_executable(SampleProject main.cpp)
target_link_libraries(SampleProject)
