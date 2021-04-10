#!/bin/bash

PATH_DIR=$PWD

export THORNADO_DIR=$PATH_DIR/thornado_mini
export THORNADO_MACHINE=mymachine
export SOURCE_ROOT=$PATH_DIR/Nekbone/src

num_n=$1

PATH_RES=$PATH_DIR/exp-results

EVENTS=mem-loads,mem-stores,instructions,cache-misses,branch-instructions,branch-misses,bus-cycles,cpu-cycles,page-faults,l1d.replacement,task-clock,context-switches

mkdir $PATH_RES

laghos_app="./laghos -p 3 -m data/rectangle01_quad.mesh -rs 2 -tf 5.0 -pa"
amg_app="./test/amg -problem 2"
xsbench_app="./XSBench -G nuclide -s large"
thornado_mini_app="./DeleptonizationProblem1D_mymachine -nX_Option=100"
halo3d_app="./halo3d -nx 100 -ny 100 -nz 100 -iterations 10000000"
examinimd_app="./src/ExaMiniMD -il input/in.lj"
macsio_app="./macsio/macsio --num_dumps 3000"
if [[ $num_n -eq 1 || $num_n -eq 2 ]]; then
  miniamr_app="./ma.x --num_tsteps 100000 --npx $num_n"
elif [[ $num_n -eq 4 ]]; then
  miniamr_app="./ma.x --num_tsteps 100000 --npx 2 --npy 2"
elif [[ $num_n -eq 8 ]]; then
  miniamr_app="./ma.x --num_tsteps 100000 --npx 2 --npy 2 --npz 2"
elif [[ $num_n -eq 16 ]]; then
  miniamr_app="./ma.x --num_tsteps 100000 --npx 4 --npy 2 --npz 2"
else
  miniamr_app="./ma.x --num_tsteps 100000 --npx 4 --npy 4 --npz 2"
fi
miniqmc_app="./bin/miniqmc -n 10000"
minivite_app="./miniVite -n 100"
nekbone_app="./nekbone"
sw4lite_app="./optimize/sw4lite tests/cartesian/basic.in"
swfft_app="./build/TestDfft 1000 128"
picsar_app="./fortran_bin/picsar examples/example_decks_fortran/laser-$num_n.pixr"
picsar2_app="./fortran_bin/picsar examples/example_decks_fortran/plane_wave_test_2d-$num_n.pixr"

NAME=$(date +"%m-%d-%y-%T")

# Laghos
cd Laghos
/usr/bin/time -o $PATH_RES/time-ecp-laghos.out -v $laghos_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-laghos.out $laghos_app
ltrace -o $PATH_RES/mpi-ecp-laghos.out $laghos_app
cat $PATH_RES/mpi-ecp-laghos.out | grep "MPI" > $PATH_RES/mpi2-ecp-laghos.out
rm $PATH_RES/mpi-ecp-laghos.out
cd $PATH_DIR

# AMG
cd AMG
/usr/bin/time -o $PATH_RES/time-ecp-amg.out -v $amg_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-amg.out $amg_app
ltrace -o $PATH_RES/mpi-ecp-amg.out $amg_app
cat $PATH_RES/mpi-ecp-amg.out | grep "MPI" > $PATH_RES/mpi2-ecp-amg.out
rm $PATH_RES/mpi-ecp-amg.out
cd $PATH_DIR

# XSBench
cd XSBench/openmp-threading
/usr/bin/time -o $PATH_RES/time-ecp-xsbenh.out -v $xsbench_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-xsbench.out $xsbench_app
ltrace -o $PATH_RES/mpi-ecp-xsbench.out $xsbench_app
cat $PATH_RES/mpi-ecp-xsbench.out | grep "MPI" > $PATH_RES/mpi2-ecp-xsbench.out
rm $PATH_RES/mpi-ecp-xsbench.out
cd $PATH_DIR

# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
/usr/bin/time -o $PATH_RES/time-ecp-thornado.out -v $thornado_mini_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-thornado.out $thornado_mini_app
ltrace -o $PATH_RES/mpi-ecp-thornado.out $thornado_mini_app
cat $PATH_RES/mpi-ecp-thornado.out | grep "MPI" > $PATH_RES/mpi2-ecp-thornado.out
rm $PATH_RES/mpi-ecp-thornado.out
cd $PATH_DIR

# Halo3D
cd ember/mpi/halo3d
/usr/bin/time -o $PATH_RES/time-ecp-ember.out -v $halo3d_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-ember.out $halo3d_app
ltrace -o $PATH_RES/mpi-ecp-ember.out $halo3d_app
cat $PATH_RES/mpi-ecp-ember.out | grep "MPI" > $PATH_RES/mpi2-ecp-ember.out
rm $PATH_RES/mpi-ecp-ember.out
cd $PATH_DIR

# ExaMiniMD
cd ExaMiniMD
/usr/bin/time -o $PATH_RES/time-ecp-examinimd.out -v $examinimd_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-examinimd.out $examinimd_app
ltrace -o $PATH_RES/mpi-ecp-examinimd.out $examinimd_app
cat $PATH_RES/mpi-ecp-examinimd.out | grep "MPI" > $PATH_RES/mpi2-ecp-examinimd.out
rm $PATH_RES/mpi-ecp-examinimd.out
cd $PATH_DIR

# MACSio
cd MACSio/build
/usr/bin/time -o $PATH_RES/time-ecp-macsio.out -v $macsio_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-macsio.out $macsio_app
ltrace -o $PATH_RES/mpi-ecp-macsio.out $macsio_app
cat $PATH_RES/mpi-ecp-macsio.out | grep "MPI" > $PATH_RES/mpi2-ecp-macsio.out
rm $PATH_RES/mpi-ecp-macsio.out
cd $PATH_DIR

# miniAMR
cd miniAMR/openmp
/usr/bin/time -o $PATH_RES/time-ecp-miniamr.out -v $miniamr_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-miniamr.out $miniamr_app
ltrace -o $PATH_RES/mpi-ecp-miniamr.out $miniamr_app
cat $PATH_RES/mpi-ecp-miniamr.out | grep "MPI" > $PATH_RES/mpi2-ecp-miniamr.out
rm $PATH_RES/mpi-ecp-miniamr.out
cd $PATH_DIR

# miniqmc
cd miniqmc/build
/usr/bin/time -o $PATH_RES/time-ecp-miniqmc.out -v $miniqmc_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-miniqmc.out $miniqmc_app
ltrace -o $PATH_RES/mpi-ecp-miniqmc.out $miniqmc_app
cat $PATH_RES/mpi-ecp-miniqmc.out | grep "MPI" > $PATH_RES/mpi2-ecp-miniqmc.out
rm $PATH_RES/mpi-ecp-miniqmc.out
cd $PATH_DIR

# miniVite
cd miniVite
/usr/bin/time -o $PATH_RES/time-ecp-minivite.out -v $minivite_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-minivite.out $minivite_app
ltrace -o $PATH_RES/mpi-ecp-minivite.out $minivite_app
cat $PATH_RES/mpi-ecp-minivite.out | grep "MPI" > $PATH_RES/mpi2-ecp-minivite.out
rm $PATH_RES/mpi-ecp-minivite.out
cd $PATH_DIR

# Nekbone
cd Nekbone/test/example1/
/usr/bin/time -o $PATH_RES/time-ecp-nekbone.out -v $nekbone_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-nekbone.out $nekbone_app
ltrace -o $PATH_RES/mpi-ecp-nekbone.out $minivite_app
cat $PATH_RES/mpi-ecp-nekbone.out | grep "MPI" > $PATH_RES/mpi2-ecp-nekbone.out
rm $PATH_RES/mpi-ecp-nekbone.out
cd $PATH_DIR

# sw4lite
cd sw4lite
/usr/bin/time -o $PATH_RES/time-ecp-sw4lite.out -v $sw4lite_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-sw4lite.out $sw4lite_app
ltrace -o $PATH_RES/mpi-ecp-sw4lite.out $sw4lite_app
cat $PATH_RES/mpi-ecp-sw4lite.out | grep "MPI" > $PATH_RES/mpi2-ecp-sw4lite.out
rm $PATH_RES/mpi-ecp-sw4lite.out
cd $PATH_DIR

# SWFFT
cd SWFFT
/usr/bin/time -o $PATH_RES/time-ecp-swfft.out -v $swfft_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-swfft.out $swfft_app
ltrace -o $PATH_RES/mpi-ecp-swfft.out $swfft_app
cat $PATH_RES/mpi-ecp-swfft.out | grep "MPI" > $PATH_RES/mpi2-ecp-swfft.out
rm $PATH_RES/mpi-ecp-swfft.out
cd $PATH_DIR

# PICSAR
cd PICSAR
/usr/bin/time -o $PATH_RES/time-ecp-picsar2.out -v $picsar2_app
sudo perf stat -e $EVENTS -o $PATH_RES/perf-ecp-picsar2.out $picsar2_app
ltrace -o $PATH_RES/mpi-ecp-picsar2.out $picsar2_app
cat $PATH_RES/mpi-ecp-picsar2.out | grep "MPI" > $PATH_RES/mpi2-ecp-picsar2.out
rm $PATH_RES/mpi-ecp-picsar2.out
cd $PATH_DIR
