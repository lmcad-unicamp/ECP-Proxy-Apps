#!/bin/bash
export THORNADO_DIR=$PATH_DIR/thornado_mini
export THORNADO_MACHINE=mymachine
export SOURCE_ROOT=$PATH_DIR/Nekbone/src
DATASET="$PWD/$1"
NAME=$(date +"%m-%d-%y-%T")
mkdir $DATASET
laghos_c_app="laghos -p 3 -m data/cube_311_hex.mesh -rs 2 -tf 5.0 -pa"
laghos_d_app="laghos -p 3 -m data/cube_522_hex.mesh -rs 2 -tf 5.0 -pa"
laghos_e_app="laghos -p 3 -m data/cube_922_hex.mesh -rs 2 -tf 5.0 -pa"
amg_c_app="./test/amg -problem 2 -n 35 35 35"
amg_d_app="./test/amg -problem 2 -n 50 50 50"
amg_e_app="./test/amg -problem 2 -n 80 80 80"
xsbench_c_app="./XSBench -G nuclide -s large"
xsbench_d_app="./XSBench -G nuclide -s xl"
xsbench_e_app="./XSBench -G nuclide -s xll"
thornado_mini_c_app="./DeleptonizationProblem1D_mymachine"
ember_c_app="./halo3d -nx 100 -ny 100 -nz 100 -iterations 1000000"
ember_d_app="./halo3d -nx 1000 -ny 1000 -nz 1000 -iterations 1000000"
ember_e_app="./halo3d -nx 10000 -ny 10000 -nz 10000 -iterations 1000000"
examinimd_c_app="./src/ExaMiniMD -il input/in-C.lj"
examinimd_d_app="./src/ExaMiniMD -il input/in-D.lj"
examinimd_e_app="./src/ExaMiniMD -il input/in-E.lj"
macsio_c_app="./macsio/macsio --part_mesh_dims 1500 1500 1500"
macsio_d_app="./macsio/macsio --part_mesh_dims 2040 2040 2040"
macsio_e_app="./macsio/macsio --part_mesh_dims 5000 5000 5000"
miniqmc_c_app="./bin/miniqmc -g 20 20 20 -n 1000"
miniqmc_d_app="./bin/miniqmc -g 30 30 30 -n 1000"
miniqmc_e_app="./bin/miniqmc -g 40 40 40 -n 1000"
minivite_c_app="./miniVite -n 100"
nekbone_c_app="./nekbone"
sw4lite_c_app="./optimize/sw4lite tests/cartesian/basic.in"
swfft_c_app="./build/TestDfft 1000 250 250 250"
swfft_d_app="./build/TestDfft 1500 300 300 300"
swfft_e_app="./build/TestDfft 1500 350 350 350"
picsar_c_app="./fortran_bin/picsar examples/example_decks_fortran/laser-$2.pixr"
picsar_d_app="./fortran_bin/picsar examples/example_decks_fortran/plane_wave_test_2d-$2.pixr"
if [[ $2 -eq 1 || $2 -eq 2 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx $2"
elif [[ $2 -eq 4 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx 2 --npy 2"
elif [[ $2 -eq 8 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx 2 --npy 2 --npz 2"
elif [[ $2 -eq 16 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx 4 --npy 2 --npz 2"
elif [[ $2 -eq 32 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx 4 --npy 4 --npz 2"
elif [[ $2 -eq 64 ]]; then
  miniamr_c_app="./ma.x --num_tsteps 100000 --npx 4 --npy 4 --npz 4"
fi
# Laghos
cd Laghos
mpirun -n $2 --hostfile hostfile ./$laghos_c_app > $DATASET/$NAME-laghos-C.out 2> $DATASET/$NAME-laghos-C.err
mpirun -n $2 --hostfile hostfile ./$laghos_d_app > $DATASET/$NAME-laghos-D.out 2> $DATASET/$NAME-laghos-D.err
mpirun -n $2 --hostfile hostfile ./$laghos_e_app > $DATASET/$NAME-laghos-E.out 2> $DATASET/$NAME-laghos-E.err
cd ..
# AMG
cd AMG
mpirun -n $2 --hostfile hostfile ./$amg_c_app > $DATASET/$NAME-amg-C.out 2> $DATASET/$NAME-amg-C.err
mpirun -n $2 --hostfile hostfile ./$amg_d_app > $DATASET/$NAME-amg-D.out 2> $DATASET/$NAME-amg-D.err
mpirun -n $2 --hostfile hostfile ./$amg_e_app > $DATASET/$NAME-amg-E.out 2> $DATASET/$NAME-amg-E.err
cd cd ..
# XSBench
cd XSBench/openmp-threading
mpirun -n $2 --hostfile hostfile ./$xsbench_c_app > $DATASET/$NAME-xsbench-C.out 2> $DATASET/$NAME-xsbench-C.err
mpirun -n $2 --hostfile hostfile ./$xsbench_d_app > $DATASET/$NAME-xsbench-D.out 2> $DATASET/$NAME-xsbench-D.err
mpirun -n $2 --hostfile hostfile ./$xsbench_e_app > $DATASET/$NAME-xsbench-E.out 2> $DATASET/$NAME-xsbench-E.err
cd ../..
# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
mpirun -n $2 --hostfile hostfile ./$thornado_mini_c_app > $DATASET/$NAME-thornado-mini-C.out 2> $DATASET/$NAME-thornado-mini-C.err
cd ../../..
# Ember/Halo3D
cd ember/mpi/halo3d
mpirun -n $2 --hostfile hostfile ./$ember_c_app > $DATASET/$NAME-ember-C.out 2> $DATASET/$NAME-ember-C.err
mpirun -n $2 --hostfile hostfile ./$ember_d_app > $DATASET/$NAME-ember-D.out 2> $DATASET/$NAME-ember-D.err
mpirun -n $2 --hostfile hostfile ./$ember_e_app > $DATASET/$NAME-ember-E.out 2> $DATASET/$NAME-ember-E.err
cd ../../..
# ExaMiniMD
cd ExaMiniMD
mpirun -n $2 --hostfile hostfile ./$examinimd_c_app > $DATASET/$NAME-examinimd-C.out 2> $DATASET/$NAME-examinimd-C.err
mpirun -n $2 --hostfile hostfile ./$examinimd_d_app > $DATASET/$NAME-examinimd-D.out 2> $DATASET/$NAME-examinimd-D.err
mpirun -n $2 --hostfile hostfile ./$examinimd_e_app > $DATASET/$NAME-examinimd-E.out 2> $DATASET/$NAME-examinimd-E.err
cd ..
# MACSio
cd MACSio/build
mpirun -n $2 --hostfile hostfile ./$macsio_c_app > $DATASET/$NAME-macsio-C.out 2> $DATASET/$NAME-macsio-C.err
mpirun -n $2 --hostfile hostfile ./$macsio_d_app > $DATASET/$NAME-macsio-D.out 2> $DATASET/$NAME-macsio-D.err
mpirun -n $2 --hostfile hostfile ./$macsio_e_app > $DATASET/$NAME-macsio-E.out 2> $DATASET/$NAME-macsio-E.err
cd ../..
# miniAMR
cd miniAMR/openmp
mpirun -n $2 --hostfile hostfile ./$miniamr_c_app > $DATASET/$NAME-miniamr-C.out 2> $DATASET/$NAME-miniamr-C.err
cd ../..
# miniqmc
cd miniqmc/build
mpirun -n $2 --hostfile hostfile ./$miniqmc_c_app > $DATASET/$NAME-miniqmc-C.out 2> $DATASET/$NAME-miniqmc-C.err
mpirun -n $2 --hostfile hostfile ./$miniqmc_d_app > $DATASET/$NAME-miniqmc-D.out 2> $DATASET/$NAME-miniqmc-D.err
mpirun -n $2 --hostfile hostfile ./$miniqmc_e_app > $DATASET/$NAME-miniqmc-E.out 2> $DATASET/$NAME-miniqmc-E.err
cd ../..
# miniVite
cd miniVite
mpirun -n $2 --hostfile hostfile ./$minivite_c_app > $DATASET/$NAME-minivite-C.out 2> $DATASET/$NAME-minivite-C.err
cd ..
# Nekbone
cd Nekbone/test/example1/
mpirun -n $2 --hostfile hostfile ./$nekbone_c_app > $DATASET/$NAME-nekbone-C.out 2> $DATASET/$NAME-nekbone-C.err
cd ../../..
# sw4lite
cd sw4lite
mpirun -n $2 --hostfile hostfile ./$sw4lite_c_app > $DATASET/$NAME-sw4lite-C.out 2> $DATASET/$NAME-sw4lite-C.err
cd ..
# SWFFT
cd SWFFT
mpirun -n $2 --hostfile hostfile ./$swfft_c_app > $DATASET/$NAME-swfft-C.out 2> $DATASET/$NAME-swfft-C.err
mpirun -n $2 --hostfile hostfile ./$swfft_d_app > $DATASET/$NAME-swfft-D.out 2> $DATASET/$NAME-swfft-D.err
mpirun -n $2 --hostfile hostfile ./$swfft_e_app > $DATASET/$NAME-swfft-E.out 2> $DATASET/$NAME-swfft-E.err
cd ..
# PICSAR
cd PICSAR
mpirun -n $2 --hostfile hostfile ./$picsar_c_app > $DATASET/$NAME-picsar-C.out 2> $DATASET/$NAME-picsar-C.err
mpirun -n $2 --hostfile hostfile ./$picsar_d_app > $DATASET/$NAME-picsar-D.out 2> $DATASET/$NAME-picsar-D.err
cd ..
