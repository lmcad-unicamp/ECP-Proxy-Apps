#!/bin/bash

mkdir exp-results

# Laghos
cd Laghos
/usr/bin/time -v ./laghos -p 3 -m data/rectangle01_quad.mesh -rs 2 -tf 5.0 -pa &> ../exp-results/laghos.out
cd ..

cd AMG
/usr/bin/time -v ./test/amg -problem 2 &> ../exp-results/amg.out
cd ..

cd XSBench/openmp-threading
/usr/bin/time -v ./XSBench -G nuclide -s large &> ../exp-results/xsbench.out
cd ../..
