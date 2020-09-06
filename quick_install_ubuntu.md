[TOC]

#### Ubuntu指南
##### 删除一些乱七八糟的

`sudo apt remove -y libreoffice-common unity-webapps-common thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install onboard deja-dup`

##### 安装常用软件和包
###### 安装wps
`sudo apt -y install wps-office`
###### 安装Vim
`sudo apt install -y vim`
###### 安装CMake
`sudo apt install -y cmake`
###### 安装unrar
`sudo apt install -y unrar`
###### 安装chrome

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install libappindicator1 libindicator7
sudo apt-get -f install
```

###### 安装pip3和pip
`sudo  apt install python3-pip python-pip`

###### 安装zsh
```
# 通过curl安装
sudo apt install curl,git,make
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# or 通过wget安装
sudo apt install wget git make
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

###### 使用源安装nvidia驱动
```
# 添加源
sudo add-apt-repository ppa:graphics-drivers/ppa
# 安装依赖
sudo apt install dkms lib32gcc1 libc6-i386  -y
# 安装驱动
sudo apt-get update && sudo apt-get install nvidia-396
# 此后最好重启

# 调节系统最大亮度
xrandr --output eDP-1-1 --brightness 1
```

##### 安装cuda
`sudo sh xxxxx.run`
设置环境变量
`sudo gedit /etc/profile`
在打开的文件末尾加入
```
export CUDA_HOME=/usr/local/cuda-10.0
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
更新配置
`source /etc/profile`

测试是否安装成功
`nvcc -V`

测试性能
```
cd /usr/local/cuda/samples
sudo make -j8
```

##### 安装cudnn
去 https://developer.nvidia.com/rdp/cudnn-download   ,移到解压后的文件夹里
```
tar zxvf
sudo cp include/cudnn.h /usr/local/cuda/include/
sudo cp lib64/* /usr/local/cuda/lib64/
cd /usr/local/cuda/lib64
sudo ln -sf libcudnn.so.7.6.0 libcudnn.so.7
sudo ln -sf libcudnn.so.7 libcudnn.so
sudo ldconfig -v
```


##### 安装tensorflow
```
sudo pip install -U --pre pip setuptools wheel 
sudo pip install -U --pre numpy scipy matplotlib scikit-learn scikit-image
```
##### 顺便搭建keras
```
sudo pip install -U --pre keras    
#sudo pip install -U --pre tensorflow ## CPU版本
sudo pip3 install -U --pre tensorflow-gpu     //安装tensorflow到python3
sudo pip install -U --pre tensorflow-gpu      //安装tensorflow到python
```

##### 安装opencv,caffe等
```
# 安装依赖包
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev -y
sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev -y
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev -y
sudo apt-get install git cmake build-essential -y
# 检查是否安装成功  
sudo apt-get install git cmake build-essential 
# 禁用 nouveau
sudo gedit /etc/modprobe.d/blacklist-nouveau.conf
# 写入
blacklist nouveau option nouveau modeset=0 
# 使其生效
sudo update-initramfs -u
# 配置环境变量
sudo gedit ~/.bashrc
# 加入
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH 
# 保存退出

# 安装opencv
# 去https://opencv.org/releases.html下载对应安装包，解压到想安装的路径，然后进入文件夹，打开命令行
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
# 注意 如果是cuda10则需要额外添加-DENABLE_PRECOMPILED_HEADERS=OFF
make -j8
sudo make install
#查看安装版本    
pkg-config --modversion opencv  

# 安装caffe
# 在你想安装的路径打开命令行
git clone https://github.com/BVLC/caffe.git
sudo cp Makefile.config.example Makefile.config
sudo gedit Makefile.config


修改 Makefile.config 文件内容：
将
#USE_CUDNN := 1
修改成： 
USE_CUDNN := 1
将
#OPENCV_VERSION := 3 
修改为： 
OPENCV_VERSION := 3
将
#WITH_PYTHON_LAYER := 1 
修改为 
WITH_PYTHON_LAYER := 1
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib 
修改为： 
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/hdf5/serial  
    

修改 Makefile 文件内容：
sudo gedit Makefile
将：
NVCCFLAGS +=-ccbin=$(CXX) -Xcompiler-fPIC $(COMMON_FLAGS)
替换为：
NVCCFLAGS += -D_FORCE_INLINES -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)
将：
LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5
改为：
LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial

make all -j8
sudo make runtest -j8
```


##### 安装dlib
`sudo pip3 install dlib`

#### 实用脚本
##### 更换gcc版本
```
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 10
```

##### 查看opencv版本
pkg-config --modversion opencv

##### 配置虚拟环境python

```
sudo apt install virtualenvwrapper
mkdir $HOME/.virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/share/virtualenvwrapper.sh
```


