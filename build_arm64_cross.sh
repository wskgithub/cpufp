#!/bin/bash

################################################################################
# ARM64 Cross-Compilation Build Script for cpufp
################################################################################
# This script cross-compiles cpufp for ARM64 architecture on x86_64 host
# using the aarch64-linux-gnu-gcc toolchain.
#
# Prerequisites:
#   - gcc-aarch64-linux-gnu
#   - g++-aarch64-linux-gnu
#
# Installation (Ubuntu/Debian):
#   sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
#
# Installation (Fedora/RHEL):
#   sudo dnf install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
#
# Usage:
#   # Use default features (ASIMD, ASIMD_HP, ASIMD_DP)
#   ./build_arm64_cross.sh
#
#   # Specify custom features
#   ARM64_FEATURES="_ASIMD_ _ASIMD_HP_" ./build_arm64_cross.sh
#
#   # Build with all features including SVE
#   ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_ _SVE_" ./build_arm64_cross.sh
#
# Available ARM64 SIMD Features:
#   _ASIMD_     - Basic NEON/ASIMD (ARMv8.0-A)
#   _ASIMD_HP_  - Half-precision FP (ARMv8.2-A+fp16)
#   _ASIMD_DP_  - Dot Product (ARMv8.2-A+dotprod)
#   _I8MM_      - Int8 Matrix Multiply (ARMv8.6-A+i8mm)
#   _BF16_      - BFloat16 (ARMv8.6-A+bf16)
#   _SVE_       - Scalable Vector Extension (ARMv8.5-A+sve)
#
# Output:
#   cpufp_arm64              - ARM64 executable for target device
#   build_dir_cross/cpuid_arm64 - CPU feature detection tool for target
#
################################################################################

SRC=arm64
ASM=$SRC/asm
COMM=common
BUILD_DIR=build_dir_cross

# Cross-compile toolchain prefix
CROSS_COMPILE=aarch64-linux-gnu-
CC=${CROSS_COMPILE}gcc
CXX=${CROSS_COMPILE}g++
AS=${CROSS_COMPILE}as

# Check if cross-compile toolchain is available
if ! command -v ${CC} &> /dev/null; then
    echo "Error: ${CC} not found. Please install the cross-compile toolchain:"
    echo "  Ubuntu/Debian: sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu"
    echo "  Fedora/RHEL: sudo dnf install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu"
    exit 1
fi

# If g++ is not available, check if we can use gcc for C++ compilation
if ! command -v ${CXX} &> /dev/null; then
    echo "Error: ${CXX} not found."
    echo "Please install the C++ cross-compiler:"
    echo "  Ubuntu/Debian: sudo apt-get install g++-aarch64-linux-gnu"
    echo "  Fedora/RHEL: sudo dnf install gcc-c++-aarch64-linux-gnu"
    exit 1
fi

# Make directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf $BUILD_DIR/*
else
    mkdir $BUILD_DIR
fi

# Build common tools with cross-compiler
echo "Building common libraries..."
${CXX} -O3 -c $COMM/table.cpp -o $BUILD_DIR/table.o
${CXX} -O3 -pthread -c $COMM/smtl.cpp -o $BUILD_DIR/smtl.o

# Build cpuid for target architecture
# Note: cpuid needs to run on target to detect features, but we can pre-define features
echo "Building cpuid detection tool..."
${CC} $SRC/cpuid.c -o $BUILD_DIR/cpuid_arm64

# Define SIMD features to include
# For cross-compilation, we include all common ARM64 SIMD features
# Users can modify this list based on their target platform
if [ -z "$ARM64_FEATURES" ]; then
    # Default: include basic ASIMD features
    # Advanced features can be enabled by setting ARM64_FEATURES environment variable
    # Example: ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_"
    ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_"
    echo "Using default ARM64 features: $ARM64_FEATURES"
    echo "To specify custom features, set ARM64_FEATURES environment variable"
    echo "Available features: _ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_ _SVE_"
else
    echo "Using user-specified ARM64 features: $ARM64_FEATURES"
fi

# Check for debug mode (reduces loop iterations for faster testing in QEMU)
if [ "$CPUFP_DEBUG_MODE" = "1" ]; then
    echo "Debug mode enabled: Using 1M iterations (fast, for QEMU testing)"
    SIMD_MACRO="$SIMD_MACRO-DCPUFP_DEBUG_MODE=1 "
else
    echo "Release mode: Using 268M iterations (accurate performance measurement)"
fi

# Build assembly files
SIMD_MACRO=" "
SIMD_OBJ=" "

for SIMD in $ARM64_FEATURES; do
    echo "Assembling $SIMD..."
    SIMD_MACRO="$SIMD_MACRO-D$SIMD "
    SIMD_OBJ="$SIMD_OBJ$BUILD_DIR/$SIMD.o "
    
    # Select appropriate architecture flags based on SIMD feature
    case "$SIMD" in
        "_SVE_")
            # SVE requires ARMv8.5-A with SVE extension
            ${AS} -march=armv8.5-a+sve -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        "_I8MM_")
            # I8MM requires ARMv8.6-A with i8mm extension
            ${AS} -march=armv8.6-a+i8mm -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        "_BF16_")
            # BF16 requires ARMv8.6-A with bf16 extension
            ${AS} -march=armv8.6-a+bf16 -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        "_ASIMD_HP_")
            # Half-precision FP requires ARMv8.2-A with fp16 extension
            ${AS} -march=armv8.2-a+fp16 -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        "_ASIMD_DP_")
            # DotProd requires ARMv8.2-A with dotprod extension
            ${AS} -march=armv8.2-a+dotprod -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        "_ASIMD_")
            # Basic ASIMD is part of ARMv8.0-A
            ${AS} -march=armv8-a -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
        *)
            # Default fallback
            ${AS} -march=armv8-a -c $ASM/$SIMD.S -o $BUILD_DIR/$SIMD.o
            ;;
    esac
done

# Compile cpufp main program
echo "Compiling cpufp..."
# Determine C++ compiler flags based on features
CXX_ARCH_FLAGS=""
if [[ "$ARM64_FEATURES" == *"_SVE_"* ]]; then
    # If SVE is enabled, use ARMv8.5-A with SVE
    CXX_ARCH_FLAGS="-march=armv8.5-a+sve"
elif [[ "$ARM64_FEATURES" == *"_I8MM_"* ]] || [[ "$ARM64_FEATURES" == *"_BF16_"* ]]; then
    # If I8MM or BF16 is enabled, use ARMv8.6-A with extensions
    if [[ "$ARM64_FEATURES" == *"_I8MM_"* ]] && [[ "$ARM64_FEATURES" == *"_BF16_"* ]]; then
        CXX_ARCH_FLAGS="-march=armv8.6-a+i8mm+bf16"
    elif [[ "$ARM64_FEATURES" == *"_I8MM_"* ]]; then
        CXX_ARCH_FLAGS="-march=armv8.6-a+i8mm"
    else
        CXX_ARCH_FLAGS="-march=armv8.6-a+bf16"
    fi
elif [[ "$ARM64_FEATURES" == *"_ASIMD_DP_"* ]]; then
    # If DotProd is enabled, use ARMv8.2-A with dotprod
    CXX_ARCH_FLAGS="-march=armv8.2-a+dotprod"
elif [[ "$ARM64_FEATURES" == *"_ASIMD_HP_"* ]]; then
    # If half-precision is enabled, use ARMv8.2-A with fp16
    CXX_ARCH_FLAGS="-march=armv8.2-a+fp16"
else
    # Default to ARMv8.0-A
    CXX_ARCH_FLAGS="-march=armv8-a"
fi

${CXX} -std=gnu++17 -O3 $CXX_ARCH_FLAGS -I$COMM $SIMD_MACRO -c $SRC/cpufp.cpp -o $BUILD_DIR/cpufp.o

# Link final executable
echo "Linking cpufp..."
${CXX} -std=gnu++17 -O3 -z noexecstack -pthread -o cpufp_arm64 \
    $BUILD_DIR/cpufp.o $BUILD_DIR/smtl.o $BUILD_DIR/table.o $SIMD_OBJ

echo ""
echo "Cross-compilation completed successfully!"
echo "Output binary: cpufp_arm64"
echo "CPU detection tool: $BUILD_DIR/cpuid_arm64"
echo ""
echo "To run on target ARM64 device:"
echo "  1. Copy cpufp_arm64 to your ARM64 device"
echo "  2. Make it executable: chmod +x cpufp_arm64"
echo "  3. Run: ./cpufp_arm64"
echo ""
echo "To detect target CPU features, copy and run cpuid_arm64 on target device:"
echo "  ./cpuid_arm64"

