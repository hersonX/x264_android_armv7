#!/bin/bash

NDK=/Users/HX/Software/dev/android/android-ndk-r10d
if [ "$NDK" = "" ]; then
	echo NDK variable not set, assuming ${HOME}/android-ndk
	export NDK=${HOME}/android-ndk-r5b
fi

SYSROOT=$NDK/platforms/android-21/arch-arm
# Expand the prebuilt/* path into the correct one
TOOLCHAIN=`echo $NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64`
export PATH=$TOOLCHAIN/bin:$PATH

# Don't build any neon version for now
for version in armv5te armv7a neon; do

	DEST=./dest
	FLAGS="--host=arm-linux --cross-prefix=arm-linux-androideabi-"
	FLAGS="$FLAGS --sysroot=$SYSROOT"
	FLAGS="$FLAGS --enable-pic --disable-pthread --disable-avs-input --disable-lavf-input --disable-ffms-input --disable-mp4-output"

	case "$version" in
		neon)
			EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon"
			EXTRA_LDFLAGS="-Wl,--fix-cortex-a8"
			# Runtime choosing neon vs non-neon requires
			# renamed files
			ABI="neon-v7a"
			;;
		armv7a)
			EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp"
			EXTRA_LDFLAGS=""
			ABI="armeabi-v7a"
			;;
		*)
                        FLAGS="$FLAGS --disable-asm"
			EXTRA_CFLAGS=""
			EXTRA_LDFLAGS=""
			ABI="armeabi"
			;;
	esac
	DEST="$DEST/$ABI"
	FLAGS="$FLAGS --prefix=$DEST"

	mkdir -p $DEST
	echo $FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" > $DEST/info.txt
	./configure $FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" | tee $DEST/configuration.txt
	[ $PIPESTATUS == 0 ] || exit 1
	make clean
	make -j4 || exit 1
	make install || exit 1

done

