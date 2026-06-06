
# output file for the post build test of the double precision library
FILENAME_DOUBLE="double_build_$(date +%Y-%m-%d_%H-%M-%S).txt"


# output file for the post build test of the float library
FILENAME_FLOAT="float_build_$(date +%Y-%m-%d_%H-%M-%S).txt"


# delete the library files from the last build
LIB_DIR="./shared_libs"

if [ -d "$LIB_DIR" ] && [ "$(ls -A "$LIB_DIR")" ]; then
    rm -rf "$LIB_DIR"/*
fi


# cd into the src directory
cd fftw-3.3.11


# clean build artifacts from the last build
make clean


# configure the build source for the double precision library build
./configure CFLAGS="-arch arm64 -O3" --enable-armv8-cntvct-el0 --enable-shared --enable-threads --enable-neon --host=aarch64-apple-darwin


# build it
make


# run and log test results for the double precision build
echo "tests/bench c512x512" >> ../tests/"$FILENAME_DOUBLE"
tests/bench c512x512 >> ../tests/"$FILENAME_DOUBLE"
echo "tests/bench r512x512" >> ../tests/"$FILENAME_DOUBLE"
tests/bench r512x512 >> ../tests/"$FILENAME_DOUBLE"
echo "tests/bench -opatient c512x512" >> ../tests/"$FILENAME_DOUBLE"
tests/bench -opatient c512x512 >> ../tests/"$FILENAME_DOUBLE"
echo "tests/bench -opatient r512x512" >> ../tests/"$FILENAME_DOUBLE"
tests/bench -opatient r512x512 >> ../tests/"$FILENAME_DOUBLE"


# copies the binaries into the shared_libs diectory
cp -a .libs/libfftw3.* ../shared_libs


# clean build artifacts from the last build
make clean


# configure the build source for the float library build
./configure CFLAGS="-arch arm64 -O3" --enable-armv8-cntvct-el0 --enable-shared --enable-threads --enable-float --enable-neon --host=aarch64-apple-darwin

# build it
make


# run and log test results for the float build
echo "tests/bench c512x512" >> ../tests/"$FILENAME_FLOAT"
tests/bench c512x512 >> ../tests/"$FILENAME_FLOAT"
echo "tests/bench r512x512" >> ../tests/"$FILENAME_FLOAT"
tests/bench r512x512 >> ../tests/"$FILENAME_FLOAT"
echo "tests/bench -opatient c512x512" >> ../tests/"$FILENAME_FLOAT"
tests/bench -opatient c512x512 >> ../tests/"$FILENAME_FLOAT"
echo "tests/bench -opatient r512x512" >> ../tests/"$FILENAME_FLOAT"
tests/bench -opatient r512x512 >> ../tests/"$FILENAME_FLOAT"


# copies the binaries into the shared_libs diectory
cp -a .libs/libfftw3f.* ../shared_libs


# clean build artifacts from the last build
make clean
