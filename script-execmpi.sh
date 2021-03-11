#!/bin/bash

PATH_DIR=$PWD

export THORNADO_DIR=$PATH_DIR/thornado_mini
export THORNADO_MACHINE=mymachine
export SOURCE_ROOT=$PATH_DIR/Nekbone/src

num_n=$1

PATH_RES=$PATH_DIR/exp-results

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

NAME=$(date +"%m-%d-%y-%T")

# Laghos
cd Laghos
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $laghos_app &> $PATH_RES/$NAME-laghos.out
cd $PATH_DIR

# AMG
cd AMG
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $amg_app &> $PATH_RES/$NAME-amg.out
cd $PATH_DIR

# XSBench
cd XSBench/openmp-threading
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $xsbench_app &> $PATH_RES/$NAME-xsbench.out
cd $PATH_DIR

# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $thornado_mini_app &> $PATH_RES/$NAME-thornado_mini.out
cd $PATH_DIR

# Halo3D
cd ember/mpi/halo3d
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $halo3d_app &> $PATH_RES/$NAME-halo3d.out
cd $PATH_DIR

# ExaMiniMD
cd ExaMiniMD
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $examinimd_app &> $PATH_RES/$NAME-examinimd.out
cd $PATH_DIR

# MACSio
cd MACSio/build
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $macsio_app &> $PATH_RES/$NAME-macsio.out
cd $PATH_DIR

# miniAMR
cd miniAMR/openmp
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $miniamr_app &> $PATH_RES/$NAME-miniamr.out
cd $PATH_DIR

# miniqmc
cd miniqmc/build
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $miniqmc_app &> $PATH_RES/$NAME-miniqmc.out
cd $PATH_DIR
#
# miniVite
cd miniVite
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $minivite_app &> $PATH_RES/$NAME-minivite.out
cd $PATH_DIR

# Nekbone
cd Nekbone/test/example1/
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $nekbone_app &> $PATH_RES/$NAME-nekbone.out
cd $PATH_DIR

# sw4lite
cd sw4lite
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $sw4lite_app &> $PATH_RES/$NAME-sw4lite.out
cd $PATH_DIR

# SWFFT
cd SWFFT
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $swfft_app &> $PATH_RES/$NAME-swfft.out
cd $PATH_DIR

# PICSAR
cd PICSAR
/usr/bin/time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n $picsar_app &> $PATH_RES/$NAME-picsar.out
cd $PATH_DIR
