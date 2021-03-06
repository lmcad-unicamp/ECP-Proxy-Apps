#!/bin/bash

export THORNADO_DIR=$PWD/thornado_mini
export THORNADO_MACHINE=mymachine
export SOURCE_ROOT=$PATH_DIR/Nekbone/src

num_n=$1

PATH_DIR=$PWD
PATH_RES=$PATH_DIR/exp-results

rm -rf $PATH_RES
mkdir $PATH_RES

laghos_app="./laghos -p 3 -m data/rectangle01_quad.mesh -rs 2 -tf 5.0 -pa"
amg_app="./test/amg -problem 2"
xsbench_app="./XSBench -G nuclide -s large"
thornado_mini_app="./DeleptonizationProblem1D_mymachine -nX_Option=100"
halo3d_app="./halo3d -nx 100 -ny 100 -nz 100 -iterations 10000000"
examinimd_app="./src/ExaMiniMD -il input/in.lj"
macsio_app="./macsio/macsio --num_dumps 3000"
miniamr_app="./ma.x --num_tsteps 100000"
miniqmc_app="./bin/miniqmc -n 10000"
minivite_app="./miniVite -n 100"
nekbone_app="./nekbone"
sw4lite_app="./optimize/sw4lite tests/cartesian/basic.in"
swfft_app="./build/TestDfft 1000 128"
picsar_app="./fortran_bin/picsar examples/example_decks_fortran/test.pixr"

## Laghos
#cd Laghos
#/usr/bin/time -o $PATH_RES/laghos.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $laghos_app &> $PATH_RES/laghos.out
#cd $PATH_DIR
#
## AMG
#cd AMG
#/usr/bin/time -o $PATH_RES/amg.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $amg_app &> $PATH_RES/amg.out
#cd $PATH_DIR
#
## XSBench
#cd XSBench/openmp-threading
#/usr/bin/time -o $PATH_RES/xsbench.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $xsbench_app &> $PATH_RES/xsbench.out
#cd $PATH_DIR
#
## THORNADO-MINI
#cd thornado_mini/DeleptonizationProblem/Executables
#/usr/bin/time -o $PATH_RES/thornado_mini.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $thornado_mini_app &> $PATH_RES/thornado_mini.out
#cd $PATH_DIR
#
## Halo3D
#cd ember/mpi/halo3d
#/usr/bin/time -o $PATH_RES/halo3d.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $halo3d_app &> $PATH_RES/halo3d.out
#cd $PATH_DIR
#
## ExaMiniMD
#cd ExaMiniMD
#/usr/bin/time -o $PATH_RES/examinimd.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $examinimd_app &> $PATH_RES/examinimd.out
#cd $PATH_DIR
#
## MACSio
#cd MACSio/build
#/usr/bin/time -o $PATH_RES/macsio.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $macsio_app &> $PATH_RES/macsio.out
#cd $PATH_DIR
#
## miniAMR
#cd miniAMR/openmp
#/usr/bin/time -o $PATH_RES/miniamr.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $miniamr_app &> $PATH_RES/miniamr.out
#cd $PATH_DIR
#
## miniqmc
#cd miniqmc/build
#/usr/bin/time -o $PATH_RES/miniqmc.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $miniqmc_app &> $PATH_RES/miniqmc.out
#cd $PATH_DIR
##
## miniVite
#cd miniVite
#/usr/bin/time -o $PATH_RES/minivite.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $minivite_app &> $PATH_RES/minivite.out
#cd $PATH_DIR

# Nekbone
cd Nekbone/test/example1/
/usr/bin/time -o $PATH_RES/nekbone.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $nekbone_app &> $PATH_RES/nekbone.out
cd $PATH_DIR

## sw4lite
#cd sw4lite
#/usr/bin/time -o $PATH_RES/sw4lite.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $sw4lite_app &> $PATH_RES/sw4lite.out
#cd $PATH_DIR
#
## SWFFT
#cd SWFFT
#/usr/bin/time -o $PATH_RES/swfft.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $swfft_app &> $PATH_RES/swfft.out
#cd $PATH_DIR
#
## PICSAR
#cd PICSAR
#/usr/bin/time -o $PATH_RES/picsar.time -v mpirun --hostfile $PATH_DIR/hostfile -n $num_n -v $picsar_app &> $PATH_RES/picsar.out
#cd $PATH_DIR
