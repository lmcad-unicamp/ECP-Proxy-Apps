#!/bin/bash

# Laghos-hypre
cd hypre/src
./configure --disable-fortran
make -j2
cd ../..

# Laghos-metis
cd metis-4.0.3
make -j2
cd ..

# Laghos-mfem
cd mfem
make parallel -j2
cd ..

# Laghos
cd Laghos
make
cd ..

cd AMG
make
cd ..

cd XSBench/openmp-threading
make
cd ../..
