git clone https://github.com/thaisacs/PI-HPC-Bench.git --recursive
cd PI-HPC-Bench
git submodule foreach git checkout master
git submodule foreach git pull origin master
#cd ASC-Proxy-Apps
#git submodule foreach git checkout master
#git submodule foreach git pull origin master
cd ECP-Proxy-Apps
git submodule foreach git checkout master
git submodule foreach git pull origin master
