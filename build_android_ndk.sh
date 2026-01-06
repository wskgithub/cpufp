#!/bin/bash

################################################################################
# Android NDK Build Script for cpufp (ARM64)
################################################################################
# This script builds cpufp for Android ARM64 devices using the Android NDK
# on macOS host.
#
# Prerequisites:
#   - Android NDK installed (tested with NDK r23+)
#   - Set ANDROID_NDK environment variable to your NDK path, or the script
#     will try to auto-detect from common locations.
#
# Usage:
#   # Use default features (ASIMD, ASIMD_HP, ASIMD_DP)
#   ./build_android_ndk.sh
#
#   # Specify custom features
#   ARM64_FEATURES="_ASIMD_ _ASIMD_HP_" ./build_android_ndk.sh
#
#   # Build with all common features
#   ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_" ./build_android_ndk.sh
#
#   # Build with SVE support (requires ARMv8.5-A+ CPU)
#   ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _SVE_ _SVE_DP_ _SVE_HP_ _SVE_BF16_ _SVE_I8MM_" ./build_android_ndk.sh
#
#   # Specify custom NDK path
#   ANDROID_NDK=/path/to/ndk ./build_android_ndk.sh
#
#   # Specify minimum Android API level (default: 24)
#   ANDROID_API=28 ./build_android_ndk.sh
#
# Available ARM64 SIMD Features:
#   _ASIMD_     - Basic NEON/ASIMD (ARMv8.0-A)
#   _ASIMD_HP_  - Half-precision FP (ARMv8.2-A+fp16)
#   _ASIMD_DP_  - Dot Product (ARMv8.2-A+dotprod)
#   _I8MM_      - Int8 Matrix Multiply (ARMv8.6-A+i8mm)
#   _BF16_      - BFloat16 (ARMv8.6-A+bf16)
#   _SVE_       - Scalable Vector Extension (ARMv8.2-A+sve)
#   _SVE_DP_    - SVE with Dot Product (ARMv8.2-A+sve)
#   _SVE_HP_    - SVE with Half-precision FP (ARMv8.2-A+sve)
#   _SVE_BF16_  - SVE with BFloat16 (ARMv8.6-A+sve+bf16)
#   _SVE_I8MM_  - SVE with Int8 Matrix Multiply (ARMv8.6-A+sve+i8mm)
# Output:
#   cpufp_android_arm64 - ARM64 executable for Android device
#
################################################################################

set -e  # Exit on error

# Source directories
SRC=arm64
ASM=$SRC/asm
COMM=common
BUILD_DIR=build_dir_android

# Target Android API level (minimum API 24 for arm64 bionic libc)
ANDROID_API=${ANDROID_API:-24}

# Auto-detect NDK path if not set
if [ -z "$ANDROID_NDK" ]; then
    # Try common macOS NDK locations
    POSSIBLE_PATHS=(
        "$HOME/Library/Android/sdk/ndk"
        "/opt/android-ndk"
        "/usr/local/android-ndk"
    )
    
    for BASE_PATH in "${POSSIBLE_PATHS[@]}"; do
        if [ -d "$BASE_PATH" ]; then
            # Find the latest NDK version
            LATEST_NDK=$(ls -1 "$BASE_PATH" 2>/dev/null | sort -V | tail -n1)
            if [ -n "$LATEST_NDK" ]; then
                ANDROID_NDK="$BASE_PATH/$LATEST_NDK"
                break
            fi
        fi
    done
fi

if [ -z "$ANDROID_NDK" ] || [ ! -d "$ANDROID_NDK" ]; then
    echo "Error: Android NDK not found."
    echo "Please set ANDROID_NDK environment variable to your NDK installation path."
    echo "Example: export ANDROID_NDK=/path/to/android-ndk-r25c"
    exit 1
fi

echo "Using Android NDK: $ANDROID_NDK"
echo "Target API level: $ANDROID_API"

# Detect host platform
HOST_OS=$(uname -s | tr '[:upper:]' '[:lower:]')
HOST_ARCH=$(uname -m)

if [ "$HOST_OS" == "darwin" ]; then
    HOST_TAG="darwin-x86_64"
    # Apple Silicon Macs also use darwin-x86_64 for NDK (Rosetta 2)
    if [ "$HOST_ARCH" == "arm64" ]; then
        # Check if darwin-arm64 exists (NDK r25+)
        if [ -d "$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-arm64" ]; then
            HOST_TAG="darwin-arm64"
        fi
    fi
elif [ "$HOST_OS" == "linux" ]; then
    HOST_TAG="linux-x86_64"
else
    echo "Error: Unsupported host OS: $HOST_OS"
    exit 1
fi

# NDK toolchain paths
TOOLCHAIN="$ANDROID_NDK/toolchains/llvm/prebuilt/$HOST_TAG"
if [ ! -d "$TOOLCHAIN" ]; then
    echo "Error: NDK toolchain not found at $TOOLCHAIN"
    exit 1
fi

# Set up compilers (using clang from NDK)
CC="$TOOLCHAIN/bin/aarch64-linux-android${ANDROID_API}-clang"
CXX="$TOOLCHAIN/bin/aarch64-linux-android${ANDROID_API}-clang++"
AR="$TOOLCHAIN/bin/llvm-ar"
STRIP="$TOOLCHAIN/bin/llvm-strip"

# Verify compilers exist
if [ ! -f "$CC" ]; then
    echo "Error: C compiler not found: $CC"
    echo "Please check your NDK installation and API level."
    exit 1
fi

if [ ! -f "$CXX" ]; then
    echo "Error: C++ compiler not found: $CXX"
    echo "Please check your NDK installation and API level."
    exit 1
fi

echo "Using compiler: $CC"

# Create/clean build directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"/*
else
    mkdir -p "$BUILD_DIR"
fi

# Common compiler flags for Android
COMMON_CFLAGS="-O3 -fPIE -fPIC"
COMMON_LDFLAGS="-pie -static-libstdc++"

# Build common libraries
echo ""
echo "=== Building common libraries ==="
echo "Compiling table.cpp..."
"$CXX" $COMMON_CFLAGS -std=c++17 -c "$COMM/table.cpp" -o "$BUILD_DIR/table.o"

echo "Compiling smtl.cpp..."
"$CXX" $COMMON_CFLAGS -std=c++17 -pthread -c "$COMM/smtl.cpp" -o "$BUILD_DIR/smtl.o"

# Build cpuid for Android (static linking for better compatibility)
echo ""
echo "=== Building cpuid detection tool ==="
"$CC" $COMMON_CFLAGS -static -o "$BUILD_DIR/cpuid_android" "$SRC/cpuid.c" 2>/dev/null || \
"$CC" $COMMON_CFLAGS -pie -o "$BUILD_DIR/cpuid_android" "$SRC/cpuid.c"
echo "Built: $BUILD_DIR/cpuid_android"

# Define SIMD features to include
if [ -z "$ARM64_FEATURES" ]; then
    ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_"
    echo ""
    echo "=== Using default ARM64 features ==="
    echo "Features: $ARM64_FEATURES"
    echo ""
    echo "To specify custom features, set ARM64_FEATURES environment variable:"
    echo "  ARM64_FEATURES=\"_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_\" ./build_android_ndk.sh"
    echo "  ARM64_FEATURES=\"_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _SVE_ _SVE_DP_ _SVE_HP_ _SVE_BF16_ _SVE_I8MM_\" ./build_android_ndk.sh"
else
    echo ""
    echo "=== Using user-specified ARM64 features ==="
    echo "Features: $ARM64_FEATURES"
fi

# Debug mode support
EXTRA_DEFS=""
if [ "$CPUFP_DEBUG_MODE" = "1" ]; then
    echo ""
    echo "Debug mode enabled: Using 1M iterations (fast, for testing)"
    EXTRA_DEFS="-DCPUFP_DEBUG_MODE=1"
else
    echo ""
    echo "Release mode: Using 268M iterations (accurate performance measurement)"
fi

# Build assembly files
echo ""
echo "=== Assembling SIMD kernels ==="
SIMD_MACRO=" $EXTRA_DEFS"
SIMD_OBJ=""

for SIMD in $ARM64_FEATURES; do
    echo "Assembling $SIMD..."
    SIMD_MACRO="$SIMD_MACRO -D$SIMD"
    SIMD_OBJ="$SIMD_OBJ $BUILD_DIR/$SIMD.o"
    
    # Select appropriate architecture flags based on SIMD feature
    case "$SIMD" in
        "_SVE_")
            # SVE requires ARMv8.2-A with SVE extension
            ARCH_FLAGS="-march=armv8.2-a+sve"
            ;;
        "_SVE_DP_")
            # SVE dot product requires SVE2 extension
            ARCH_FLAGS="-march=armv8.2-a+sve"
            ;;
        "_SVE_HP_")
            # SVE half-precision requires ARMv8.2-A with SVE extension
            ARCH_FLAGS="-march=armv8.2-a+sve"
            ;;
        "_SVE_BF16_")
            # SVE BFloat16 requires ARMv8.6-A with SVE and BFloat16 extension
            ARCH_FLAGS="-march=armv8.6-a+sve+bf16"
            ;;
        "_SVE_I8MM_")
            # SVE Int8 Matrix Multiply requires ARMv8.6-A with SVE and i8mm extensions
            ARCH_FLAGS="-march=armv8.6-a+sve+i8mm"
            ;;
        "_I8MM_")
            # I8MM requires ARMv8.6-A with i8mm extension
            ARCH_FLAGS="-march=armv8.6-a+i8mm"
            ;;
        "_BF16_")
            # BF16 requires ARMv8.6-A with bf16 extension
            ARCH_FLAGS="-march=armv8.6-a+bf16"
            ;;
        "_ASIMD_HP_")
            # Half-precision FP requires ARMv8.2-A with fp16 extension
            ARCH_FLAGS="-march=armv8.2-a+fp16"
            ;;
        "_ASIMD_DP_")
            # DotProd requires ARMv8.2-A with dotprod extension
            ARCH_FLAGS="-march=armv8.2-a+dotprod"
            ;;
        "_ASIMD_")
            # Basic ASIMD is part of ARMv8.0-A
            ARCH_FLAGS="-march=armv8-a"
            ;;
        *)
            # Default fallback
            ARCH_FLAGS="-march=armv8-a"
            ;;
    esac
    
    # Use clang as assembler (supports .S files with preprocessing)
    "$CC" $COMMON_CFLAGS $ARCH_FLAGS -c "$ASM/$SIMD.S" -o "$BUILD_DIR/$SIMD.o"
done

# Determine best architecture flags for cpufp.cpp compilation
echo ""
echo "=== Compiling cpufp main program ==="
CXX_ARCH_FLAGS="-march=armv8-a"

if [[ "$ARM64_FEATURES" == *"_SVE_DP_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.2-a+sve"
elif [[ "$ARM64_FEATURES" == *"_SVE_HP_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.2-a+sve"
elif [[ "$ARM64_FEATURES" == *"_SVE_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.2-a+sve"
elif [[ "$ARM64_FEATURES" == *"_SVE_BF16_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.6-a+sve+bf16"
elif [[ "$ARM64_FEATURES" == *"_SVE_I8MM_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.6-a+sve+i8mm"
elif [[ "$ARM64_FEATURES" == *"_I8MM_"* ]] || [[ "$ARM64_FEATURES" == *"_BF16_"* ]]; then
    if [[ "$ARM64_FEATURES" == *"_I8MM_"* ]] && [[ "$ARM64_FEATURES" == *"_BF16_"* ]]; then
        CXX_ARCH_FLAGS="-march=armv8.6-a+i8mm+bf16"
    elif [[ "$ARM64_FEATURES" == *"_I8MM_"* ]]; then
        CXX_ARCH_FLAGS="-march=armv8.6-a+i8mm"
    else
        CXX_ARCH_FLAGS="-march=armv8.6-a+bf16"
    fi
elif [[ "$ARM64_FEATURES" == *"_ASIMD_DP_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.2-a+dotprod"
elif [[ "$ARM64_FEATURES" == *"_ASIMD_HP_"* ]]; then
    CXX_ARCH_FLAGS="-march=armv8.2-a+fp16"
fi

echo "Using architecture flags: $CXX_ARCH_FLAGS"
"$CXX" -std=c++17 $COMMON_CFLAGS $CXX_ARCH_FLAGS -I"$COMM" $SIMD_MACRO -c "$SRC/cpufp.cpp" -o "$BUILD_DIR/cpufp.o"

# Link final executable
echo ""
echo "=== Linking final executable ==="
"$CXX" -std=c++17 -O3 -fPIE -pie -Wl,-z,noexecstack -pthread \
    -static-libstdc++ \
    -o cpufp_android_arm64 \
    "$BUILD_DIR/cpufp.o" "$BUILD_DIR/smtl.o" "$BUILD_DIR/table.o" $SIMD_OBJ

# Strip the binary for smaller size (optional)
if [ -f "$STRIP" ] && [ "$CPUFP_NO_STRIP" != "1" ]; then
    echo "Stripping binary..."
    "$STRIP" cpufp_android_arm64
fi

# Show build results
echo ""
echo "========================================"
echo "Build completed successfully!"
echo "========================================"
echo ""
echo "Output files:"
echo "  - cpufp_android_arm64        : Main benchmark executable"
echo "  - $BUILD_DIR/cpuid_android   : CPU feature detection tool"
echo ""
echo "File size: $(ls -lh cpufp_android_arm64 | awk '{print $5}')"
echo ""
echo "To run on Android device:"
echo "  1. Connect your Android device with USB debugging enabled"
echo "  2. Push the binary:"
echo "     adb push cpufp_android_arm64 /data/local/tmp/"
echo "  3. Make it executable and run:"
echo "     adb shell chmod +x /data/local/tmp/cpufp_android_arm64"
echo "     adb shell /data/local/tmp/cpufp_android_arm64 --thread_pool=[0]"
echo ""
echo "To detect CPU features on device (optional):"
echo "     adb push $BUILD_DIR/cpuid_android /data/local/tmp/"
echo "     adb shell chmod +x /data/local/tmp/cpuid_android"
echo "     adb shell /data/local/tmp/cpuid_android"
echo ""

