# 使用Ubuntu 18.04官方镜像作为基础镜像
FROM ubuntu:18.04

# 设置环境变量以避免软件包安装过程中的用户交互
ENV DEBIAN_FRONTEND=noninteractive

# 更换为国内镜像源并安装基础依赖
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirrors.ustc.edu.cn/ubuntu/|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        autoconf \
        automake \
        autopoint \
        libglib2.0-dev \
        libtool \
        openjdk-8-jdk \
        python-dev \
        unzip \
        libeigen3-dev \
        mesa-common-dev \
        freeglut3-dev \
        coinor-libipopt-dev \
        libblas-dev \
        liblapack-dev \
        gfortran \
        cmake \
        wget \
        libxkbcommon-x11-0 \
        libxcb-xinerama0 \
        libxkbcommon0 \
        libxkbcommon-dev \
        libfontconfig1 \
        libdbus-1-3 \
        libx11-xcb1 \
        libxi6 \
        libxtst6 \
        libxrender1 \
        libxcb1 \
        libfreetype6 \
        x11-apps \
        libgtk-3-0 \
        qt5-default \
        qtbase5-dev \
        qtbase5-dev-tools \
        qttools5-dev-tools
        
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# 设置环境变量以使用X11
ENV DISPLAY=:0

# 复制Eigen头文件到/usr/local/include/
RUN cp -r /usr/include/eigen3 /usr/local/include/

# 安装Qt
COPY qt-opensource-linux-x64-5.10.0.run /tmp/qt-opensource-linux-x64-5.10.0.run
RUN chmod +x /tmp/qt-opensource-linux-x64-5.10.0.run

# 下载、构建和安装LCM
RUN wget https://github.com/lcm-proj/lcm/archive/refs/tags/v1.4.0.zip -O lcm-1.4.0.zip && \
    unzip lcm-1.4.0.zip && \
    cd lcm-1.4.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install && \
    cd ../.. && \
    rm -rf lcm-1.4.0 lcm-1.4.0.zip && \
    export LCM_INSTALL_DIR=/usr/local/lib && \
    echo $LCM_INSTALL_DIR > /etc/ld.so.conf.d/lcm.conf && \
    ldconfig

# # 复制mini cheetah代码
# COPY wbc /home/wbc

# # 设置工作目录
# WORKDIR /home/wbc

# # 将代码复制到容器中
# COPY . .

# # 编译项目
# RUN mkdir mc-build && \
#     cd mc-build && \
#     cmake -DMINI_CHEETAH_BUILD=TRUE .. && \
#     make -j4
