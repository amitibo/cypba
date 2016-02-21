from setuptools import setup
from setuptools.extension import Extension
from distutils.sysconfig import get_python_lib
from Cython.Distutils import build_ext
import numpy as np
import os.path
import sys
#from distutils.core import setup
#from distutils.extension import Extension
#from Cython.Distutils import build_ext

NAME = 'pypba'
PACKAGE_NAME = 'pba'
VERSION = '0.2.2'
DESCRIPTION = 'A cython wrapper for the Parallel Bundle Adjustment'
LONG_DESCRIPTION = DESCRIPTION
AUTHOR = 'Amit Aides'
EMAIL = 'amitibo@campus.technion.ac.il'
LICENSE = 'GPL'

def main():
    setup(
        name=NAME,
        version=VERSION,
        description=DESCRIPTION,
        long_description=LONG_DESCRIPTION,
        author=AUTHOR,
        author_email=EMAIL,
        license=LICENSE,
        packages=[PACKAGE_NAME],
        cmdclass = {'build_ext': build_ext},
        ext_modules=[
            Extension(
                name="pypba",
                sources=[
                    "cython/cypba.pyx",
                    "src/pba/pba.cpp",
                    "src/pba/ConfigBA.cpp",
                    "src/pba/SparseBundleCPU.cpp"
                    ],
                include_dirs=[np.get_include()]+["src/pba"],
                language="c++",
                extra_compile_args=['-DPBA_NO_GPU', '/EHsc'],
                #libraries=['SparseBundleCPU', 'pba', 'ConfigBA']
            )
            ],
    )
    

if __name__ == '__main__':
    main()