#!/bin/bash

# Laghos-hypre
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
#cd AMG
#make
#cd ..

export THORNADO_DIR=$HOME/Dev/master/PI-Bench/ECP-Proxy-Apps/thornado_mini
export THORNADO_MACHINE=mymachine

cd thornado_mini/DeleptonizationProblem/Executables
make
mkdir ../Output
cd ../../..

#cd XSBench/openmp-threading
#make
