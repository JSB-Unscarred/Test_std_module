add_rules("mode.debug", "mode.release")

-- 设置使用clang工具链
set_toolchains("clang")

target("Test")
    set_kind("binary")
    set_languages("c++23")
    add_files("src/*.cpp")
    
    -- 设置编译器
    set_toolset("cxx", "clang++-20")
    set_toolset("cc", "clang-20")
    set_toolset("ld", "clang++-20")
    
    -- 为clang-20添加C++23支持和模块
    add_cxxflags("-std=c++23", "-stdlib=libc++", {force = true})
    add_ldflags("-stdlib=libc++", {force = true})
    
    -- 添加预编译模块的路径
    add_cxxflags("-fmodule-file=std=" .. os.projectdir() .. "/std.pcm", {force = true})
    
    -- 确保在编译前先编译std模块
    before_build(function (target)
        local std_module = "/usr/lib/llvm-20/share/libc++/v1/std.cppm"
        local std_pcm = os.projectdir() .. "/std.pcm"
        
        if not os.isfile(std_pcm) or os.mtime(std_module) > os.mtime(std_pcm) then
            print("Compiling std module...")
            os.execv("clang++-20", {"-std=c++23", "-stdlib=libc++", "--precompile", std_module, "-o", std_pcm})
        end
    end)
    
    -- 启用模块支持
    add_cxxflags("-fmodules", {force = true})
--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro definition
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

