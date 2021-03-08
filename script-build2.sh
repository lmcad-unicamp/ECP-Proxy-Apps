#!/bin/bash

PATH_DIR=$PWD

export THORNADO_DIR=$PATH_DIR/thornado_mini
export SOURCE_ROOT=$PATH_DIR/Nekbone/src
export KOKKOS_PATH=${PATH_DIR}/kokkos
export THORNADO_MACHINE=mymachine

# Laghos
cd Laghos
make
cd $PATH_DIR

# AMG
cd AMG
make
cd $PATH_DIR

# THORNADO-MINI
THORNADO_EXE_DIR=$THORNADO_DIR/DeleptonizationProblem/Executables
cp $PATH_DIR/thornado-tables/EquationOfStateTable.h5 $THORNADO_EXE_DIR
cp $PATH_DIR/thornado-tables/OpacityTable.h5 $THORNADO_EXE_DIR
cd $THORNADO_EXE_DIR
make
mkdir $THORNADO_DIR/DeleptonizationProblem/Output
cd $PATH_DIR

# XSBench
cd XSBench/openmp-threading
make
cd $PATH_DIR

# Ember
cd ember/mpi/halo3d
make
cd $PATH_DIR

# ExaMiniMD
cd ExaMiniMD
make
cd $PATH_DIR

# MACSio
cd MACSio
mkdir build
cd build
cmake ..
make
cd $PATH_DIR

# miniAMR
cd miniAMR/openmp
make
cd $PATH_DIR

# miniqmc
cd miniqmc
mkdir build
cd build
cmake -D CMAKE_CXX_COMPILER=mpic++ .. -D ENABLE_OPENMP=OFF ..
make
cd $PATH_DIR

# miniVite
cd miniVite
make
cd $PATH_DIR

# Nekbone
cd Nekbone/test/example1/
./makenek
cd $PATH_DIR

# sw4lite
cd sw4lite
make
cd $PATH_DIR

# SWFFT
cd SWFFT
make
cd $PATH_DIR

# PICSAR
cd PICSAR
make
cd $PATH_DIR
