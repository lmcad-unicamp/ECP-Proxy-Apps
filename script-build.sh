#!/bin/bash

export THORNADO_DIR=$1
export THORNADO_MACHINE=mymachine

## Laghos-hypre
#cd hypre/src
#./configure --disable-fortran
#make -j2
#cd ../..
#
## Laghos-metis
#cd metis-4.0.3
#make -j2
#cd ..
#
## Laghos-mfem
#cd mfem
#make parallel -j2
#cd ..
#
## Laghos
#cd Laghos
#make
#cd ..
#
## AMG
#cd AMG
#make
#cd ..

# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
make
cp ../../../thornado-tables/mini-app/wl-EOS-SFHo-15-25-50-noBCK.h5 EquationOfStateTable.h5
cp ../../../thornado-tables/mini-app/wl-Op-SFHo-15-25-50-noBCK.h5 OpacityTable.h5
mkdir ../Output
cd ../../..

## XSBench
#cd XSBench/openmp-threading
#make
#cd ../..
#
## Ember
#cd ember/mpi/halo3d
#make
#cd ../../..
#
## ExaMiniMD
#cd ExaMiniMD
#make
#cd ..
#
## MACSio
#cd MACSio
#mkdir build
#cd build
#cmake ..
#make
#cd ../..
#
## miniAMR
#cd miniAMR/openmp
#make
#cd ../..
#
## miniqmc
#cd miniqmc
#mkdir build
#cd build
#cmake -D CMAKE_CXX_COMPILER=mpic++ .. -D ENABLE_OPENMP=OFF ..
#make
#cd ../..
#
## miniVite
#cd miniVite
#make
#cd ..
#
## Nekbone
#cd Nekbone/test/example1/
#./makenek
#cd ../../..
#
## sw4lite
#cd sw4lite
#make
#cd ..
#
## SWFFT
#cd SWFFT
#make
#cd ..
#
## PICSAR
#cd PICSAR
#make
#cd ..
