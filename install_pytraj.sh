#!/bin/sh

git clone https://github.com/hainm/pytraj
# disable openmp
cd pytraj
python setup.py install  $OPENMP
export LD_LIBRARY_PATH=/home/travis/build/hainm/TestPytraj/pytraj/cpptraj/lib:$LD_LIBRARY_PATH
python runtests.py sim
# openmp
git clean -fdx .
rm -rf cpptraj
python setup.py install
python runtests.py sim
# pip with cythonized files
git clean -fdx .
./devtools/mkrelease
conda remove cython --yes
cd cpptraj
export CPPTRAJHOME=`pwd`
cd ../
pip install dist/*gz
