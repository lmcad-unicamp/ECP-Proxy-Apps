#!/bin/bash

cd ..

export THORNADO_DIR=$PATH_DIR/thornado_mini
export THORNADO_MACHINE=mymachine

# Kokkos
cd kokkos
git clean -f -d
cd ..

# Laghos-hypre
cd hypre
git clean -f -d
cd ..

# Laghos-metis
cd metis-4.0.3
git clean -f -d
cd ..

# Laghos-mfem
cd mfem
git clean -f -d
cd ..

# Laghos
cd Laghos
git clean -f -d
cd ..

# AMG
cd AMG
git clean -f -d
cd ..

# THORNADO-MINI
cd thornado_mini
git clean -f -d
cd ..

# XSBench
cd XSBench
git clean -f -d
cd ..

# Ember
cd ember
git clean -f -d
cd ..

# ExaMiniMD
cd ExaMiniMD
git clean -f -d
cd ..

# MACSio
cd MACSio
git clean -f -d
cd ..

# miniAMR
cd miniAMR
git clean -f -d
cd ..

# miniqmc
cd miniqmc
git clean -f -d
cd ..

# miniVite
cd miniVite
git clean -f -d
cd ..

# Nekbone
cd Nekbone
git clean -f -d
cd ..

# sw4lite
cd sw4lite
git clean -f -d
cd ..

# SWFFT
cd SWFFT
git clean -f -d
cd ..

# PICSAR
cd PICSAR
git clean -f -d
cd ..
