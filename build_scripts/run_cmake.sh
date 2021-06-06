wget https://github.com/Kitware/CMake/releases/download/v3.20.3/cmake-3.20.3.tar.gz
tar -xvzf cmake-3.20.3.tar.gz
cd cmake-3.20.3
./configure
make
PATH=$PATH:~/cmake-3.20.3/bin/cmake
cd ~
git clone https://github.com/LLNL/json-cwx.git
cd json-cwx/json-cwx
sh autogen.sh
./configure
make
sudo make install
#~/cmake-3.20.3/bin/cmake
