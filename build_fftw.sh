
############################################################################
#
#   build_fftw.sh
#
#   Created by Michael Papp on 06-04-2026.
#
#   Copyright © 2026 Michael Papp. All rights reserved.
#
############################################################################




############################################################################

# define the file directory paths

############################################################################

# define the root directory for this project
ROOT_DIR="$PWD"


# define the root directory for the official fftw source code
FFTW_SRC="fftw-3.3.11"


# define the root directory for test files
TEST_ROOT_DIR="$ROOT_DIR/tests"


# output file for the post build test of the double precision library
FILENAME_DOUBLE="double_build_$(date +%Y-%m-%d_%H-%M-%S).txt"

# and where the double benchmark output file goes
DOUBLE_FILE_OUTPUT="$TEST_ROOT_DIR/$FILENAME_DOUBLE"


# output file for the post build test of the float library
FILENAME_FLOAT="float_build_$(date +%Y-%m-%d_%H-%M-%S).txt"

# and where the float benchmark output file goes
FLOAT_FILE_OUTPUT="$TEST_ROOT_DIR/$FILENAME_FLOAT"


# the shared_lib directory from the src directory
LIB_ROOT_DIR="$ROOT_DIR/shared_libs"


# define the root directory for the include file
INCLUDE_ROOT_DIR="$ROOT_DIR/include"



############################################################################

# setup for the build

############################################################################

# cd into the src directory
cd "$FFTW_SRC"


# delete the library files from the last build
if [ -d "$LIB_ROOT_DIR" ] && [ "$(ls -A "$LIB_ROOT_DIR")" ]; then
    rm -rf "$LIB_ROOT_DIR"/libfftw3.*
    rm -rf "$LIB_ROOT_DIR"/libfftw3f.*
fi


# delete the header file from the last build
if [ -d "$INCLUDE_ROOT_DIR" ] && [ "$(ls -A "$INCLUDE_ROOT_DIR")" ]; then
    rm -rf "$INCLUDE_ROOT_DIR"/*.h
fi


# ensure there are no build artifacts from the last build
make clean


############################################################################

# build the double precision static and shared libraries

############################################################################

# configure the build source for the double precision library build
./configure CFLAGS="-arch arm64 -O3" --enable-armv8-cntvct-el0 --enable-shared --enable-threads --enable-neon --host=aarch64-apple-darwin


# build it
make


# run and log test results for the double precision build
echo "tests/bench c512x512" >> "$DOUBLE_FILE_OUTPUT"
tests/bench c512x512 >> "$DOUBLE_FILE_OUTPUT"
echo "tests/bench r512x512" >> "$DOUBLE_FILE_OUTPUT"
tests/bench r512x512 >> "$DOUBLE_FILE_OUTPUT"
echo "tests/bench -opatient c512x512" >> "$DOUBLE_FILE_OUTPUT"
tests/bench -opatient c512x512 >> "$DOUBLE_FILE_OUTPUT"
echo "tests/bench -opatient r512x512" >> "$DOUBLE_FILE_OUTPUT"
tests/bench -opatient r512x512 >> "$DOUBLE_FILE_OUTPUT"


# copies the binaries into the shared_libs diectory
cp -a .libs/libfftw3.* "$LIB_ROOT_DIR"


# clean build artifacts from the last build
make clean


############################################################################

# build the float static and shared libraries

############################################################################


# configure the build source for the float library build
./configure CFLAGS="-arch arm64 -O3" --enable-armv8-cntvct-el0 --enable-shared --enable-threads --enable-float --enable-neon --host=aarch64-apple-darwin

# build it
make


# run and log test results for the float build
echo "tests/bench c512x512" >> "$FLOAT_FILE_OUTPUT"
tests/bench c512x512 >> "$FLOAT_FILE_OUTPUT"
echo "tests/bench r512x512" >> "$FLOAT_FILE_OUTPUT"
tests/bench r512x512 >> "$FLOAT_FILE_OUTPUT"
echo "tests/bench -opatient c512x512" >> "$FLOAT_FILE_OUTPUT"
tests/bench -opatient c512x512 >> "$FLOAT_FILE_OUTPUT"
echo "tests/bench -opatient r512x512" >> "$FLOAT_FILE_OUTPUT"
tests/bench -opatient r512x512 >> "$FLOAT_FILE_OUTPUT"


# copies the binaries into the shared_libs diectory
cp -a .libs/libfftw3f.* "$LIB_ROOT_DIR"


############################################################################

# copy the header file and clean up one last time

############################################################################

# finally, we copy the header file into 
cp -a api/fftw3.h "$INCLUDE_ROOT_DIR"


# clean build artifacts from the last build
make clean
