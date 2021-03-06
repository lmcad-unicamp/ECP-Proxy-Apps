#!/bin/bash

PATH_DIR=$PWD

export THORNADO_DIR=$1
export THORNADO_MACHINE=mymachine

# Laghos-hypre
cd hypre/src
./configure --disable-fortran
make -j2
cd $PATH_DIR

# Laghos-metis
cd metis-4.0.3
make -j2
cd $PATH_DIR

# Laghos-mfem
cd mfem
make parallel -j2
cd $PATH_DIR

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
cp /home/thais/Dev/master/experiments-master/PI-Bench/ECP-Proxy-Apps/thornado-tables/EquationOfStateTable.h5 $THORNADO_EXE_DIR
/home/thais/Dev/master/experiments-master/PI-Bench/ECP-Proxy-Apps/thornado-tables/OpacityTable.h5 $THORNADO_EXE_DIR
cd $THORNADO_EXE_DIR
make

mkdir ../Output
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
