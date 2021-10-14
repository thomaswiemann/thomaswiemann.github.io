---
layout: blog
title: Getting Started with Google Cloud Computing
usemathjax: true
published: false
summary: 
tags: [Tutorial, Coding, Cloud Computing]
---

# {{ page.title }}

1. google cloud computing account USD300 trial
2. Creating a project
3. Setting up a VM
   1. type of VM; possibility to add GPU
   2. Region
4. Connect to VM
   1. Generating ssh key
   2. adding ssh key to project meta data
   3. connecting to VM via console
   4. connecting to VM via CS Code
5. Setting up VM
   1. sudo apt update
   2. sudo apt upgrade
   3. julia
   4. python
   5. R





6. Setting up VM
   1. Julia
```bash
wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.3-linux-x86_64.tar.gz
tar zxvf julia-1.6.3-linux-x86_64.tar.gz

echo 'export PATH=$PATH:~/julia-1.6.3/bin' >> ~/.bashrc

source ~/.bashrc
```

for VS code, possibly need to add to path, possibly allow for pasting code to REPL

2. Python3


```bash
sudo apt install python3


wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar zxvf Python-3.10.0.tgz

cd Python-3.10.0
./configure --enable-optimizations

sudo apt install make
make -j 12

echo 'export PATH=$PATH:~/julia-1.6.3/bin' >> ~/.bashrc

source ~/.bashrc
```

Hi Ernesto,

thanks a lot for helping me out with this! 

