#!/bin/bash

cd ..

PATH_DIR=$PWD

export THORNADO_DIR=$PATH_DIR/thornado_mini
export SOURCE_ROOT=$PATH_DIR/Nekbone/src
export KOKKOS_PATH=${PATH_DIR}/kokkos
export THORNADO_MACHINE=mymachine

# Kokkos
cd kokkos
mkdir build
cd build
cmake ..
make

cd $PATH_DIR

# Laghos-hypre
cd hypre/src
./configure --disable-fortran
make

cd $PATH_DIR

# Laghos-metis
cd metis-4.0.3
make

cd $PATH_DIR

# Laghos-mfem
cd mfem
make parallel

cd $PATH_DIR
