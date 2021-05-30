#!/bin/bash
export THORNADO_DIR=$PATH_DIR/thornado_mini
export THORNADO_MACHINE=mymachine
export SOURCE_ROOT=$PATH_DIR/Nekbone/src
HOSTFILE=$PWD/hostfile
DATASET=$PWD/$1
NAME=$(date +"%m-%d-%y-%T")
mkdir $DATASET
laghos_a_app="laghos -p 3 -m data/cube_311_hex.mesh -rs 2 -tf 5.0 -pa"
laghos_b_app="laghos -p 3 -m data/cube_522_hex.mesh -rs 2 -tf 5.0 -pa"
laghos_c_app="laghos -p 3 -m data/cube_922_hex.mesh -rs 2 -tf 5.0 -pa"
amg_a_app="test/amg -problem 2 -n 35 35 35"
amg_b_app="test/amg -problem 2 -n 50 50 50"
amg_c_app="test/amg -problem 2 -n 80 80 80"
xsbench_a_app="XSBench -G nuclide -s large"
xsbench_b_app="XSBench -G nuclide -s xl"
xsbench_c_app="XSBench -G nuclide -s xll"
thornado_mini_a_app="DeleptonizationProblem1D_mymachine"
ember_a_app="halo3d -nx 100 -ny 100 -nz 100 -iterations 1000000"
ember_b_app="halo3d -nx 1000 -ny 1000 -nz 1000 -iterations 1000000"
ember_c_app="halo3d -nx 10000 -ny 10000 -nz 10000 -iterations 1000000"
examinimd_a_app="src/ExaMiniMD -il input/in-C.lj"
examinimd_b_app="src/ExaMiniMD -il input/in-D.lj"
examinimd_c_app="src/ExaMiniMD -il input/in-E.lj"
macsio_a_app="macsio/macsio --part_mesh_dims 1500 1500 1500"
macsio_b_app="macsio/macsio --part_mesh_dims 2040 2040 2040"
macsio_c_app="macsio/macsio --part_mesh_dims 5000 5000 5000"
miniqmc_a_app="bin/miniqmc -g 20 20 20 -n 1000"
miniqmc_b_app="bin/miniqmc -g 30 30 30 -n 1000"
miniqmc_c_app="bin/miniqmc -g 40 40 40 -n 1000"
minivite_a_app="miniVite -n 100"
nekbone_a_app="nekbone"
sw4lite_a_app="optimize/sw4lite tests/cartesian/basic.in"
swfft_a_app="build/TestDfft 1000 250 250 250"
swfft_b_app="build/TestDfft 1500 300 300 300"
swfft_c_app="build/TestDfft 1500 350 350 350"
picsar_a_app="fortran_bin/picsar examples/example_decks_fortran/laser-$2.pixr"
picsar_b_app="fortran_bin/picsar examples/example_decks_fortran/plane_wave_test_2d-$2.pixr"
if [[ $2 -eq 1 || $2 -eq 2 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx $2"
elif [[ $2 -eq 4 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx 2 --npy 2"
elif [[ $2 -eq 8 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx 2 --npy 2 --npz 2"
elif [[ $2 -eq 16 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx 4 --npy 2 --npz 2"
elif [[ $2 -eq 32 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx 4 --npy 4 --npz 2"
elif [[ $2 -eq 64 ]]; then
  miniamr_a_app="ma.x --num_tsteps 100000 --npx 4 --npy 4 --npz 4"
fi
# Laghos
cd Laghos
mpirun -n $2 --hostfile $HOSTFILE ./$laghos_a_app > $DATASET/$NAME-laghos-A.out 2> $DATASET/$NAME-laghos-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$laghos_b_app > $DATASET/$NAME-laghos-B.out 2> $DATASET/$NAME-laghos-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$laghos_c_app > $DATASET/$NAME-laghos-C.out 2> $DATASET/$NAME-laghos-C.err
cd ..
# AMG
cd AMG
mpirun -n $2 --hostfile $HOSTFILE ./$amg_a_app > $DATASET/$NAME-amg-A.out 2> $DATASET/$NAME-amg-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$amg_b_app > $DATASET/$NAME-amg-B.out 2> $DATASET/$NAME-amg-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$amg_c_app > $DATASET/$NAME-amg-C.out 2> $DATASET/$NAME-amg-C.err
cd cd ..
# XSBench
cd XSBench/openmp-threading
mpirun -n $2 --hostfile $HOSTFILE ./$xsbench_a_app > $DATASET/$NAME-xsbench-A.out 2> $DATASET/$NAME-xsbench-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$xsbench_b_app > $DATASET/$NAME-xsbench-B.out 2> $DATASET/$NAME-xsbench-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$xsbench_c_app > $DATASET/$NAME-xsbench-C.out 2> $DATASET/$NAME-xsbench-C.err
cd ../..
# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
mpirun -n $2 --hostfile $HOSTFILE ./$thornado_mini_a_app > $DATASET/$NAME-thornado-mini-A.out 2> $DATASET/$NAME-thornado-mini-A.err
cd ../../..
# Ember/Halo3D
cd ember/mpi/halo3d
mpirun -n $2 --hostfile $HOSTFILE ./$ember_a_app > $DATASET/$NAME-ember-A.out 2> $DATASET/$NAME-ember-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$ember_b_app > $DATASET/$NAME-ember-B.out 2> $DATASET/$NAME-ember-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$ember_c_app > $DATASET/$NAME-ember-C.out 2> $DATASET/$NAME-ember-C.err
cd ../../..
# ExaMiniMD
cd ExaMiniMD
mpirun -n $2 --hostfile $HOSTFILE ./$examinimd_a_app > $DATASET/$NAME-examinimd-A.out 2> $DATASET/$NAME-examinimd-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$examinimd_b_app > $DATASET/$NAME-examinimd-B.out 2> $DATASET/$NAME-examinimd-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$examinimd_c_app > $DATASET/$NAME-examinimd-C.out 2> $DATASET/$NAME-examinimd-C.err
cd ..
# MACSio
cd MACSio/build
mpirun -n $2 --hostfile $HOSTFILE ./$macsio_a_app > $DATASET/$NAME-macsio-A.out 2> $DATASET/$NAME-macsio-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$macsio_b_app > $DATASET/$NAME-macsio-B.out 2> $DATASET/$NAME-macsio-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$macsio_c_app > $DATASET/$NAME-macsio-C.out 2> $DATASET/$NAME-macsio-C.err
cd ../..
# miniAMR
cd miniAMR/openmp
mpirun -n $2 --hostfile $HOSTFILE ./$miniamr_a_app > $DATASET/$NAME-miniamr-A.out 2> $DATASET/$NAME-miniamr-A.err
cd ../..
# miniqmc
cd miniqmc/build
mpirun -n $2 --hostfile $HOSTFILE ./$miniqmc_a_app > $DATASET/$NAME-miniqmc-A.out 2> $DATASET/$NAME-miniqmc-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$miniqmc_b_app > $DATASET/$NAME-miniqmc-B.out 2> $DATASET/$NAME-miniqmc-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$miniqmc_c_app > $DATASET/$NAME-miniqmc-C.out 2> $DATASET/$NAME-miniqmc-C.err
cd ../..
# miniVite
cd miniVite
mpirun -n $2 --hostfile $HOSTFILE ./$minivite_a_app > $DATASET/$NAME-minivite-A.out 2> $DATASET/$NAME-minivite-A.err
cd ..
# Nekbone
cd Nekbone/test/example1/
mpirun -n $2 --hostfile $HOSTFILE ./$nekbone_a_app > $DATASET/$NAME-nekbone-A.out 2> $DATASET/$NAME-nekbone-A.err
cd ../../..
# sw4lite
cd sw4lite
mpirun -n $2 --hostfile $HOSTFILE ./$sw4lite_a_app > $DATASET/$NAME-sw4lite-A.out 2> $DATASET/$NAME-sw4lite-A.err
cd ..
# SWFFT
cd SWFFT
mpirun -n $2 --hostfile $HOSTFILE ./$swfft_a_app > $DATASET/$NAME-swfft-A.out 2> $DATASET/$NAME-swfft-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$swfft_b_app > $DATASET/$NAME-swfft-B.out 2> $DATASET/$NAME-swfft-B.err
mpirun -n $2 --hostfile $HOSTFILE ./$swfft_c_app > $DATASET/$NAME-swfft-C.out 2> $DATASET/$NAME-swfft-C.err
cd ..
# PICSAR
cd PICSAR
mpirun -n $2 --hostfile $HOSTFILE ./$picsar_a_app > $DATASET/$NAME-picsar-A.out 2> $DATASET/$NAME-picsar-A.err
mpirun -n $2 --hostfile $HOSTFILE ./$picsar_b_app > $DATASET/$NAME-picsar-B.out 2> $DATASET/$NAME-picsar-B.err
cd ..
