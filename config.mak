prefix=./dest/neon-v7a
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
ARCH=ARM
SYS=LINUX
CC=arm-linux-androideabi-gcc
CFLAGS=-O3 -fno-fast-math  -Wall -I. --sysroot=/Users/HX/Software/dev/android/android-ndk-r10d/platforms/android-21/arch-arm -march=armv7-a -mfloat-abi=softfp -mfpu=neon -std=gnu99 -fPIC -s -fomit-frame-pointer
LDFLAGS= --sysroot=/Users/HX/Software/dev/android/android-ndk-r10d/platforms/android-21/arch-arm -Wl,--fix-cortex-a8 -lm -Wl,-Bsymbolic -s
LDFLAGSCLI=
AR=arm-linux-androideabi-ar
RANLIB=arm-linux-androideabi-ranlib
STRIP=arm-linux-androideabi-strip
AS=arm-linux-androideabi-gcc
ASFLAGS=  -Wall -I. --sysroot=/Users/HX/Software/dev/android/android-ndk-r10d/platforms/android-21/arch-arm -march=armv7-a -mfloat-abi=softfp -mfpu=neon -std=gnu99 -c -DPIC
EXE=
VIS=no
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
