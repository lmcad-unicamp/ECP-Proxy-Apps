#!/bin/bash

cd ..

PATH_DIR=$PWD

export THORNADO_DIR=$PATH_DIR/thornado_mini
export SOURCE_ROOT=$PATH_DIR/Nekbone/src
export KOKKOS_PATH=${PATH_DIR}/kokkos
export THORNADO_MACHINE=mymachine

# Laghos
cd Laghos
make -j

cd $PATH_DIR

# AMG
cd AMG
make -j

cd $PATH_DIR

# THORNADO-MINI
THORNADO_EXE_DIR=$THORNADO_DIR/DeleptonizationProblem/Executables

cd $THORNADO_EXE_DIR
./download-thornado-table.sh
unzip thornado-table.zip
make -j
mkdir $THORNADO_DIR/DeleptonizationProblem/Output

cd $PATH_DIR

# XSBench
cd XSBench/openmp-threading
make -j

cd $PATH_DIR

# Ember
cd ember/mpi/halo3d
make -j

cd $PATH_DIR

# ExaMiniMD
cd ExaMiniMD
make -j

cd $PATH_DIR

# MACSio
cd MACSio
mkdir build
cd build
cmake ..
make -j

cd $PATH_DIR

# miniAMR
cd miniAMR/openmp
make -j

cd $PATH_DIR

# miniqmc
cd miniqmc
mkdir build
cd build
cmake -D CMAKE_CXX_COMPILER=mpic++ .. -D ENABLE_OPENMP=OFF ..
make -j

cd $PATH_DIR

# miniVite
cd miniVite
make -j

cd $PATH_DIR

# Nekbone
cd Nekbone/test/example1/
./makenek

cd $PATH_DIR

# sw4lite
cd sw4lite
mkdir basic-results
make -j

cd $PATH_DIR

# SWFFT
cd SWFFT
make -j

cd $PATH_DIR

# PICSAR
cd PICSAR
make -j

cd $PATH_DIR
