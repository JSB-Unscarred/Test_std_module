# Test_std_module

这是一个用于测试C++标准库模块（std module）的项目。本项目旨在验证现代C++编译器对标准库模块的支持，特别是在使用 Clang 20 和 libc++ 20 环境下的模块编译和链接功能。

## 项目目的

- 测试C++23标准库模块的编译和使用
- 验证预编译模块（PCM）文件的生成和加载
- 探索现代C++工具链对模块系统的支持
- 为标准库模块的实际应用提供参考示例

## 目录结构

- `src/`：源代码目录，包含 `main.cpp`
- `build/`：构建输出目录（包含编译生成的文件和预编译模块）
- `xmake.lua`：xmake 构建脚本
- `test_program/`：测试程序目录

## 构建与运行

本项目使用 [xmake](https://xmake.io/) 作为构建系统，支持自动处理C++模块的依赖关系和预编译。

### 配置编译器

确保使用正确的编译器版本：

```bash
# 设置编译器环境变量
export CC=clang-20
export CXX=clang++-20
```

### 构建项目

```bash
# 清理之前的构建（可选）
xmake clean

# 配置项目
xmake config --toolchain=clang

# 编译项目
xmake
```

### 运行程序

构建完成后，主程序可在 `build/linux/x86_64/release/Test` 下找到：

```bash
./build/linux/x86_64/release/Test
```

### 查看生成的模块文件

编译过程中会在 `build/` 目录下生成预编译模块文件：

```bash
ls -la build/*.pcm
# 输出示例：
# std.pcm         - 标准库模块
# std.compat.pcm  - 兼容性模块
```

## 依赖

### 必需组件
- **Clang 20**：支持C++23模块的现代编译器
- **libc++ 20**：LLVM项目的C++标准库实现，提供完整的模块支持
- **xmake**：现代化的构建工具


### 安装依赖

```bash
# 安装 Clang 20 和 libc++
sudo apt update
sudo apt install clang-20 libc++-20-dev libc++abi-20-dev

# 安装 xmake
curl -fsSL https://xmake.io/shget.text | bash
```

## 许可证

MIT License

## 故障排除

### 常见问题

1. **编译错误：找不到模块**
   - 确保使用 Clang 20 或更高版本
   - 检查 libc++ 版本是否为 20 或更高

2. **链接错误**
   - 确保正确设置了 libc++ 库路径
   - 验证编译器标志是否正确

3. **xmake 配置问题**
   - 使用 `xmake config --show` 查看当前配置
   - 使用 `xmake config --toolchain=clang` 重新配置

### 获取帮助

如果遇到问题，请检查：
- [xmake 文档](https://xmake.io/#/zh-cn/)
- [Clang 模块文档](https://clang.llvm.org/docs/Modules.html)
- [C++23 模块规范](https://en.cppreference.com/w/cpp/language/modules)
