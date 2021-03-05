#!/bin/bash

export THORNADO_DIR=$1
export THORNADO_MACHINE=mymachine

mkdir exp-results

## Laghos
#cd Laghos
#/usr/bin/time -v ./laghos -p 3 -m data/rectangle01_quad.mesh -rs 2 -tf 5.0 -pa &> ../exp-results/laghos.out
#cd ..
#
## AMG
#cd AMG
#/usr/bin/time -v ./test/amg -problem 2 &> ../exp-results/amg.out
#cd ..
#
## XSBench
#cd XSBench/openmp-threading
#/usr/bin/time -v ./XSBench -G nuclide -s large &> ../../exp-results/xsbench.out
#cd ../..

# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
/usr/bin/time -v ./DeleptonizationProblem1D_mymachine -nX_Option=100 &> ../../../exp-results/thornado.out
cd ../../..

## Halo3D
#cd ember/mpi/halo3d
#/usr/bin/time -v ./halo3d -nx 100 -ny 100 -nz 100 -iterations 10000000 &> ../../../exp-results/halo3d.out
#cd ../../..
#
## ExaMiniMD
#cd ExaMiniMD
#/usr/bin/time -v ./src/ExaMiniMD -il input/in.lj &> ../exp-results/examinimd.out
#cd ..
#
## MACSio
#cd MACSio/build
#/usr/bin/time -v ./macsio/macsio --num_dumps 3000 &> ../../exp-results/macsio.out
#cd ../..
#
## miniAMR
#cd miniAMR/openmp
#/usr/bin/time -v ./ma.x --num_tsteps 100000 &> ../../exp-results/miniamr.out
#cd ../..
#
## miniqmc
#cd miniqmc/build
#/usr/bin/time -v ./bin/miniqmc -n 10000 &> ../../exp-results/miniqmc.out
#cd ../..
#
## miniVite
#cd miniVite
#/usr/bin/time -v ./miniVite -n 100 &> ../exp-results/minivite.out
#cd ..
#
## Nekbone
#cd Nekbone/test/example1/
#/usr/bin/time -v ./nekbone &> ../../../exp-results/nekbone.out
#cd ../../..
#
## sw4lite
#cd sw4lite
#/usr/bin/time -v ./optimize/sw4lite tests/cartesian/basic.in &> ../exp-results/sw4lite.out
#cd ..
#
## SWFFT
#cd SWFFT
#/usr/bin/time -v ./build/TestDfft 1000 128 &> ../exp-results/swfft.out
#cd ..
#
## PICSAR
#cd PICSAR
#/usr/bin/time -v ./fortran_bin/picsar examples/example_decks_fortran/test.pixr &> ../exp-results/picsar.out
#cd ..
