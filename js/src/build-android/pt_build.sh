#!/bin/bash

set -x

#//PT_NDK_ROOT=/home/jiang/Android/Sdk/ndk-bundle
PT_NDK_ROOT=/home/jiang/Android/android-ndk-r20-linux-x86_64/android-ndk-r20


SYSROOT="--sysroot=$PT_NDK_ROOT/sysroot"

FLAGS:=$SYSROOT

arch=$1


### using gcc compilers

# PT_ARM_TOOLCHAIN=$PT_NDK_ROOT/toolchains/arm-linux-androideabi-4.9
# TOOL_FOLDER=$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/arm-linux-androideabi/bin
# PT_CC=arm-linux-androideabi-gcc
# PT_CXX=arm-linux-androideabi-g++
#PT_TARGET=arm-linux-androideabi

#PT_ARM_TOOLCHAIN=$PT_NDK_ROOT/toolchains/aarch64-linux-android-4.9
#TOOL_FOLDER=$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/aarch64-linux-android/bin
#PT_CC=aarch64-linux-android-gcc
#PT_CXX=aarch64-linux-android-g++


### using clang compilers

if [ $arch == "aarch64" ] ; then

PT_ARM_TOOLCHAIN=$PT_NDK_ROOT/toolchains/llvm
TOOL_FOLDER=$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/aarch64-linux-android/bin
PT_CC=aarch64-linux-android21-clang
PT_CXX=aarch64-linux-android21-clang++
PT_TARGET=aarch64-linux-android

elif [ $arch == "armv7" ] ; then

PT_ARM_TOOLCHAIN=$PT_NDK_ROOT/toolchains/llvm
TOOL_FOLDER=$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PT_ARM_TOOLCHAIN/prebuilt/linux-x86_64/arm-linux-androideabi/bin
PT_CC=armv7a-linux-androideabi16-clang
PT_CXX=armv7a-linux-androideabi16-clang++
PT_TARGET=arm-linux-androideabi

else
   echo "bad arch"
   exit 1
fi




FLAGS+="-fvisibility=hidden"

PATH=$TOOL_FOLDER:$PATH \
	CC="$PT_CC"  \
	CXX="$PT_CXX" \
	CCFLAGS=$FLAGS \
	CXXFLAGS=$FLAGS \
	DIST=./android-build \
	JS_STANDALONE=1	\
	../configure --target=$PT_TARGET \
	--with-android-ndk=$PT_NDK_ROOT \
	--disable-tests \
	--disable-shared-js \
	--disable-debug \
	--enable-install-strip \
	--disable-js-shell \
	--enable-strip  \
	--without-intl-api 

