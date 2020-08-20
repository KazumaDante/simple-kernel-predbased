DATE_START=$(date +"%s")
# Clean out folder
rm -rf '/media/system/root1/simple-kernel-predbased/out'
# Set defaults
cd "/media/system/root1/simple-kernel-predbased"
wd=$(pwd)
out=$wd/out
BUILD="/media/system/root1/simple-kernel-predbased"
# Set kernel source workspace
cd $BUILD
# Export ARCH <arm, arm64, x86, x86_64>
export ARCH=arm64
# Export SUBARCH <arm, arm64, x86, x86_64>
export SUBARCH=arm64
# Set kernal name
# export LOCALVERSION=-
# Export Username
export KBUILD_BUILD_USER=KazuDante
# Export Machine name
export KBUILD_BUILD_HOST=xdadevelopers
# Compiler String
CC=/media/system/root1/aosp-clang/bin/clang-10
export KBUILD_COMPILER_STRING="$(${CC} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
# Make and Clean
make O=$out clean
make O=$out mrproper
# Make <defconfig>
make O=$out ARCH=arm64 lavender-perf_defconfig
# Build Kernel
make O=$out ARCH=arm64 \
CC="/media/system/root1/aosp-clang/bin/clang-10" \
CLANG_TRIPLE=aarch64-maestro-linux-gnu- \
CROSS_COMPILE="/media/system/root1/aarch64-maestro-linux-android/bin/aarch64-maestro-linux-gnu-" \
CROSS_COMPILE_ARM32="/media/system/root1/arm-maestro-linux-gnueabi/bin/arm-maestro-linux-gnueabi-" \
-j$(nproc --all) Image.gz-dtb
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
# mounting to browser
cd "/media/system/root1/simple-kernel-predbased/out/arch/arm64/boot"
python3 -m http.server 4444
