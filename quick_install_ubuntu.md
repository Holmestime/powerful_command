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

### virtualenvwrapper

```
sudo pip3 install virtualenvwrapper
mkdir $HOME/.virtualenvs

# gedit your bashrc or zshrc, the example followed is for zsh
echo "export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.zshrc

# refresh
source .zshrc
```





