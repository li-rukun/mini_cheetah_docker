### 基于Docker的Mini Cheetah开发环境搭建（ubuntu版本为18.04）

### 安装 Docker
1.更新apt缓存  
`sudo apt-get update`
2.安装docker  
`sudo apt-get install docker.io docker-compose`
3.将当前用户添加到docker用户组  
`sudo usermod -aG docker ${USER}`
4.重启docker服务  
`sudo service docker restart`

### Docker配置国内镜像源
1.使用文本编辑器打开配置文件：
`sudo gedit /etc/docker/daemon.json`
2.修改为如下配置内容:
```
{
    "registry-mirrors": [
        "https://registry.docker-cn.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com",
        "https://ccr.ccs.tencentyun.com"
    ]
}
```
保存并退出编辑器。
3.重启Docker服务：
`sudo systemctl daemon-reload`
`sudo systemctl restart docker`
4.验证是否修改成功
`docker info`

### Docker使用

##### 创建镜像
`docker build -t robot .`
注：这里将镜像名设为robot。

##### 允许本地连接
`xhost +local:docker`

##### 运行容器
```
docker run -it \
    --name mini_cheetah \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    robot
```
注：这里将容器命名为mini_cheetah。

##### 安装Qt5.10.0
打开tmp文件夹
`cd tmp/`
运行.run格式文件
`./qt-opensource-linux-x64-5.10.0.run`
按照指引进行操作，登录可跳过，安装路径选择/root/Qt，并记得勾选Qt5.10.0。

##### 到此mini_cheetah的开发环境已搭建完成。

### 其他一些常用Docker命令

##### 停止容器
`docker stop mini_cheetah`
##### 查看所有容器
`docker ps -a`
##### 启动容器
`docker start mini_cheetah`
##### 进入容器
`docker exec -it mini_cheetah /bin/bash`
##### 删除容器
`docker rm mini_cheetah`
##### 列出所有镜像
`docker images`
##### 删除所有镜像
`docker system prune -a`
