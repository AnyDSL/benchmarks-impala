#!/bin/bash
export PATH=$PATH:/home/impala/impala/build/bin
cd benchmarks-impala/
echo -e "\e[0;31mPerformance Evaluation\e[0;37m"
echo "-----------------------------"
#./run.sh
echo "-----------------------------"
echo -e "\e[0;31mHalstead Numbers\e[0;37m"
cd halstead_numbers
echo "  CloneFunction.cpp"
../../c3ms/c3ms CloneFunction.cpp
echo "  CodeExtractor.cpp"
../../c3ms/c3ms CodeExtractor.cpp
echo "  InlineFunction.cpp"
../../c3ms/c3ms InlineFunction.cpp
echo "  LoopUnroll.cpp"
../../c3ms/c3ms LoopUnroll.cpp
echo "  LLVM Total"
../../c3ms/c3ms TotalLLVM
echo "  mangle.cpp (our implementation)"
../../c3ms/c3ms mangle.cpp
