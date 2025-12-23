# ARM64 交叉编译说明 / ARM64 Cross-Compilation Guide

## 简介 / Introduction

`build_arm64_cross.sh` 是一个用于在 x86_64 主机上交叉编译 ARM64 版本 cpufp 的脚本。

`build_arm64_cross.sh` is a script for cross-compiling cpufp for ARM64 architecture on x86_64 host.

## 前置要求 / Prerequisites

### Ubuntu/Debian
```bash
sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
```

### Fedora/RHEL
```bash
sudo dnf install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
```

## 使用方法 / Usage

### 1. 使用默认特性（推荐）/ Default Features (Recommended)

默认包含：`_ASIMD_`、`_ASIMD_HP_`、`_ASIMD_DP_`

Default includes: `_ASIMD_`, `_ASIMD_HP_`, `_ASIMD_DP_`

```bash
./build_arm64_cross.sh
```

### 2. 自定义 SIMD 特性 / Custom SIMD Features

```bash
# 仅编译基础 ASIMD / Only basic ASIMD
ARM64_FEATURES="_ASIMD_" ./build_arm64_cross.sh

# 包含更多特性 / Include more features
ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_" ./build_arm64_cross.sh

# 包含所有特性（含 SVE）/ Include all features (with SVE)
ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_ _SVE_" ./build_arm64_cross.sh
```

### 3. 调试模式（用于 QEMU 测试）/ Debug Mode (for QEMU Testing)

在 QEMU 中测试时，可以启用调试模式来减少循环次数（从 268M 减少到 1M），大幅缩短运行时间：

When testing in QEMU, enable debug mode to reduce iterations (from 268M to 1M) for much faster execution:

```bash
# 调试模式编译 / Compile in debug mode
CPUFP_DEBUG_MODE=1 ./build_arm64_cross.sh

# 或组合使用 / Or combine with custom features
CPUFP_DEBUG_MODE=1 ARM64_FEATURES="_ASIMD_" ./build_arm64_cross.sh

# 在 QEMU 中运行 / Run in QEMU
qemu-aarch64 -L /usr/aarch64-linux-gnu -cpu max ./cpufp_arm64 '--thread_pool=[0]'
```

**注意 / Note:**
- 调试模式牺牲了测试精度以换取速度，仅用于快速验证程序是否能正常运行
- 在真实硬件上进行性能测试时，请使用正常模式编译
- Debug mode sacrifices accuracy for speed, only for quick verification
- Use release mode for actual performance testing on real hardware

## 可用的 SIMD 特性 / Available SIMD Features

| 特性名称 / Feature | 架构要求 / Architecture | 说明 / Description |
|-------------------|------------------------|-------------------|
| `_ASIMD_`         | ARMv8.0-A              | 基础 NEON/ASIMD / Basic NEON/ASIMD |
| `_ASIMD_HP_`      | ARMv8.2-A+fp16         | 半精度浮点 / Half-precision FP |
| `_ASIMD_DP_`      | ARMv8.2-A+dotprod      | 点积运算 / Dot Product |
| `_I8MM_`          | ARMv8.6-A+i8mm         | Int8 矩阵乘法 / Int8 Matrix Multiply |
| `_BF16_`          | ARMv8.6-A+bf16         | BFloat16 支持 / BFloat16 |
| `_SVE_`           | ARMv8.5-A+sve          | 可扩展向量扩展 / Scalable Vector Extension |

## 输出文件 / Output Files

- `cpufp_arm64` - ARM64 可执行文件，用于目标设备
- `build_dir_cross/cpuid_arm64` - CPU 特性检测工具

- `cpufp_arm64` - ARM64 executable for target device
- `build_dir_cross/cpuid_arm64` - CPU feature detection tool

## 在目标设备上运行 / Running on Target Device

### 在真实 ARM64 硬件上 / On Real ARM64 Hardware

```bash
# 1. 复制文件到 ARM64 设备 / Copy files to ARM64 device
scp cpufp_arm64 user@arm64-device:~/

# 2. 在 ARM64 设备上执行 / Run on ARM64 device
ssh user@arm64-device
chmod +x cpufp_arm64
./cpufp_arm64 '--thread_pool=[0-3]'  # 使用 0-3 号核心
```

### 在 QEMU 中测试 / Testing in QEMU

如果没有 ARM64 硬件，可以使用 QEMU 用户模式进行快速测试：

If you don't have ARM64 hardware, use QEMU user mode for quick testing:

```bash
# 1. 安装 QEMU 和 ARM64 运行时库 / Install QEMU and ARM64 runtime libraries
sudo apt-get install qemu-user qemu-user-static

# 2. 使用调试模式编译（快速）/ Compile in debug mode (fast)
CPUFP_DEBUG_MODE=1 ARM64_FEATURES="_ASIMD_" ./build_arm64_cross.sh

# 3. 在 QEMU 中运行 / Run in QEMU
qemu-aarch64 -L /usr/aarch64-linux-gnu -cpu max ./cpufp_arm64 '--thread_pool=[0]'

# 4. 测试 cpuid / Test cpuid
qemu-aarch64 -L /usr/aarch64-linux-gnu -cpu max ./build_dir_cross/cpuid_arm64
```

**QEMU 参数说明 / QEMU Parameters:**
- `-L /usr/aarch64-linux-gnu` - 指定 ARM64 库路径 / Specify ARM64 library path
- `-cpu max` - 启用最多的 CPU 特性 / Enable maximum CPU features
- `'--thread_pool=[0]'` - 单引号防止 shell 解析方括号 / Single quotes to prevent shell expansion

## CPU 特性检测 / CPU Feature Detection

如果不确定目标设备支持哪些特性，可以使用 cpuid 工具：

If unsure about target device features, use the cpuid tool:

```bash
# 复制到目标设备 / Copy to target device
scp build_dir_cross/cpuid_arm64 user@arm64-device:~/

# 在目标设备上运行 / Run on target device
./cpuid_arm64
# 输出示例 / Example output:
# _I8MM_
# _BF16_
# _ASIMD_DP_
# _ASIMD_HP_
# _ASIMD_
```

然后使用检测到的特性重新编译：

Then recompile with detected features:

```bash
ARM64_FEATURES="_ASIMD_ _ASIMD_HP_ _ASIMD_DP_ _I8MM_ _BF16_" ./build_arm64_cross.sh
```

## 故障排查 / Troubleshooting

### 问题：找不到 aarch64-linux-gnu-g++
### Issue: aarch64-linux-gnu-g++ not found

```bash
# Ubuntu/Debian
sudo apt-get install g++-aarch64-linux-gnu

# Fedora/RHEL
sudo dnf install gcc-c++-aarch64-linux-gnu
```

### 问题：编译错误 "selected processor does not support..."
### Issue: Compilation error "selected processor does not support..."

这通常意味着你选择的 SIMD 特性与汇编器支持不匹配。脚本会自动为每个特性选择正确的架构参数。

This usually means the SIMD features selected don't match the assembler support. The script automatically selects correct architecture flags for each feature.

### 问题：在目标设备上运行时出现 "Illegal instruction"
### Issue: "Illegal instruction" on target device

目标设备不支持编译时选择的某些 SIMD 特性。请使用 `cpuid_arm64` 检测目标设备的实际特性，然后重新编译。

The target device doesn't support some SIMD features selected during compilation. Use `cpuid_arm64` to detect actual features on target device, then recompile.

## 注意事项 / Notes

1. 默认特性组合（`_ASIMD_` `_ASIMD_HP_` `_ASIMD_DP_`）适用于大多数现代 ARM64 设备
2. SVE 特性需要较新的处理器支持（如 ARM Neoverse V1, Fujitsu A64FX）
3. 编译时选择的特性越多，二进制文件越大，但性能可能更好

1. Default feature set (`_ASIMD_` `_ASIMD_HP_` `_ASIMD_DP_`) works for most modern ARM64 devices
2. SVE requires newer processors (e.g., ARM Neoverse V1, Fujitsu A64FX)
3. More features = larger binary but potentially better performance

## 与本地编译的区别 / Differences from Native Build

| 项目 / Item | 本地编译 / Native | 交叉编译 / Cross |
|------------|------------------|-----------------|
| 脚本 / Script | `build_arm64.sh` | `build_arm64_cross.sh` |
| 编译器 / Compiler | 本机 gcc/g++ / Native gcc/g++ | aarch64-linux-gnu-gcc/g++ |
| 特性检测 / Feature Detection | 自动检测 / Auto-detect | 手动指定 / Manual specify |
| 输出文件 / Output | `cpufp` | `cpufp_arm64` |
| 构建目录 / Build Dir | `build_dir` | `build_dir_cross` |

