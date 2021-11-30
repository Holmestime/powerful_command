[TOC]

# Ubuntu tutorial

## Change sources

- Ubuntu apt sources

```
cd update_source
chmod +x update_source.sh
sudo ./update_source.sh
```

- Pip Source

```bash
mkdir ~/.pip
echo "[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com" >> test.txt
```

- Conda source

```bash
echo "channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
  - defaults
show_channel_urls: true" >> ~/.condarc
```

## Useful tool

- Fundamental
```bash
sudo apt install -y vim cmake unrar viewnior git curl zsh 

```

- Optional

```bash
# ZSH
sudo apt install wget git make curl
# via curl
sh -c "$(curl -fsSL https://gitee.com/holmestime/oh-my-zsh-install.sh/raw/master/install.sh)"

# via wget
sh -c "$(wget -O- https://gitee.com/holmestime/oh-my-zsh-install.sh/raw/master/install.sh)"

```

## Driver and Cuda

### Driver

```bash
# add ppa
sudo add-apt-repository ppa:graphics-drivers/ppa

# get the available ubuntu drivers
ubuntu-drivers devices

# autoinstall
sudo ubuntu-drivers autoinstall

# manual install
sudo apt install nvidia-driver-xxx

# Restart
reboot

# check
nvidia-smi


# Change the max brightness
xrandr --output eDP-1-1 --brightness 1
```

### Cuda and Cudnn

- Cuda

```
# 更换gcc版本
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
```


```
# Download the xxx.run of cuda
sudo sh xxxxx.run

# set the path
sudo echo "export CUDA_HOME=/usr/local/cuda-10.0
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> /etc/profile

# update
source /etc/profile

# check
nvcc -V

# test
cd /usr/local/cuda/samples
sudo make -j8
```

- Cudnn

```
# Download cudnn-xxx
tar zxvf cudnn-xxx
sudo cp include/cudnn.h /usr/local/cuda/include/
sudo cp lib64/* /usr/local/cuda/lib64/
cd /usr/local/cuda/lib64
sudo ln -sf libcudnn.so.7.6.0 libcudnn.so.7
sudo ln -sf libcudnn.so.7 libcudnn.so
sudo ldconfig -v
```







###### 安装chrome

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install libappindicator1 libindicator7
sudo apt-get -f install
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

##### 查看opencv版本
pkg-config --modversion opencv

##### 配置虚拟环境python

```
sudo apt install virtualenvwrapper
mkdir $HOME/.virtualenvs

# gedit your bashrc or zshrc, the example followed is for zsh
vim .zshrc

# add the things
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/share/virtualenvwrapper.sh

# refresh
source .zshrc
```


