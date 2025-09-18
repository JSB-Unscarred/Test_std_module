import std;
import std.compat;

int main(int argc, char** argv)
{
    std::cout << "Hello from C++23 with import std and std.compat!" << std::endl;
    std::cout << "Testing C++23 modules with libc++-20!" << std::endl;
    
    // 使用std模块的功能
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    std::cout << "Vector contents: ";
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // 使用std.compat模块的功能（C风格函数）
    char buffer[100];
    std::sprintf(buffer, "Formatted number: %d", 42);
    std::cout << buffer << std::endl;
    
    // 测试数学函数（来自std.compat）
    double value = 3.14159;
    std::cout << "sin(" << value << ") = " << std::sin(value) << std::endl;
    std::cout << "sqrt(16) = " << std::sqrt(16.0) << std::endl;
    
    std::string message = "C++23 modules (std + std.compat) are working!";
    std::cout << "Message: " << message << std::endl;
    std::cout << "Message length: " << message.size() << std::endl;
    
    return 0;
}
