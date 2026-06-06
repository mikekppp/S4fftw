# S4fftw

##Project to build the FFTW libraries for Apple Silicon on macOS.

### Project Overview

This project aims to develop the FFTW libraries for Apple Silicon on macOS.

###Disclaimer

This project is *not* intended as an official distribution of the [FFTW](http://www.fftw.org) libraries nor as a general source for binaries on Apple platforms.

Several applications and libraries developed under the **S4** domain require the FFTW libraries, as well as other third-party libraries. While I support and appreciate package installers such as Homebrew and MacPorts, the applications I am building necessitate the inclusion of all components within a single binary.

Furthermore, I am hesitant to link binaries installed via package managers into the applications I develop.

Consequently, the code in this repository is downloaded directly from the [FFTW downloads site](https://www.fftw.org/download.html) and decompressed into a directory named after the official FFTW version.

## Build Script
The `build_fftw.sh`script is relatively straightforward. It deletes any binaries built with the previous invocation, calls `make clean` to clear any artifacts present in the source directory, and then configures the build system for building both floating and double precision versions of the libraries. For information on the various configuration settings, refer to the official [FFTW Documentation](https://www.fftw.org/fftw3_doc/Installation-on-Unix.html). Additionally, I would like to express my gratitude to [@andrej5elin](https://github.com/andrej5elin/howto_fftw_apple_silicon) for providing guidance on constructing the optimal configuration settings for the FFTW library on Apple Silicon. 

## Building Process
This repository is made publicly available to either serve as an example of building FFTW on Apple Macintosh systems or to provide "out-of-the-box" binaries for use in your project.

To build the binaries, simply open a Terminal (or Ghostty or iTerm, etc.) in the root directory of this repository and type

`./build_fftw.sh`

The time required to complete this process may vary depending on your system (processor, memory, etc.). On my M1 system, it typically takes approximately 3 minutes. Upon completion, you will find the following artifacts:

 --- shared_libs: Static (.a) and dynamic library (.dylib) binaries for both floating and double precision versions of FFTW. Please note that the libraries are deleted each time the build script is executed.
 
 --- tests: At the conclusion of each build, a series of benchmark tests are executed, and the results are recorded in this directory. The logs are timestamped, enabling the comparison of different builds based on their benchmark performance. Notably, the test logs are not deleted with each execution of the build script, as this is done solely for this purpose.

### Note
If build_fftw.sh is not recognized as an executable file, please execute the following command: 

`chmod +x build_fftw.sh`

## Advisory
This project and any binaries compiled using the shell script are suitable for my intended applications. Currently, I do not perform any extensive testing either through the script or independently on the output of the shell script. Consequently, this project produces binaries that are **without warranty** and **use at your own risk**.

I welcome pull requests (PRs), but as mentioned above, the primary purpose of this repository is to serve the needs of the applications developed as part of my *S4* suite. PRs that support newer Apple Silicon (M*) processors or provide valuable enhancements to the build script may be considered.