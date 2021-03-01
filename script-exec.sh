#!/bin/bash

mkdir exp-results

# Laghos
cd Laghos
/usr/bin/time -v ./laghos -p 3 -m data/rectangle01_quad.mesh -rs 2 -tf 5.0 -pa &> ../exp-results/laghos.out
cd ..

# AMG
cd AMG
/usr/bin/time -v ./test/amg -problem 2 &> ../exp-results/amg.out
cd ..

# XSBench
cd XSBench/openmp-threading
/usr/bin/time -v ./XSBench -G nuclide -s large &> ../exp-results/xsbench.out
cd ../..

# THORNADO-MINI
cd thornado_mini/DeleptonizationProblem/Executables
/usr/bin/time -v ./DeleptonizationProblem1D_mymachine -nX_Option=100
cd ../../..
