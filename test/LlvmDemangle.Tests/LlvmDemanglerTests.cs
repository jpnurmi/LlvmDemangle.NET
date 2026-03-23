using Xunit;

namespace LlvmDemangle.Tests
{
    public class LlvmDemanglerTests
    {
        [Theory]
        [InlineData("_Z3foov", "foo()")]
        [InlineData("_Z3barif", "bar(int, float)")]
        [InlineData("_ZN3Foo3barEv", "Foo::bar()")]
        [InlineData("_ZN3Foo3barEi", "Foo::bar(int)")]
        [InlineData("_ZNSt6vectorIiSaIiEE9push_backERKi", "std::vector<int, std::allocator<int>>::push_back(int const&)")]
        public void Demangle_ItaniumSymbols(string mangled, string expected)
        {
            Assert.Equal(expected, LlvmDemangler.Demangle(mangled));
        }

        [Theory]
        [InlineData("?foo@@YAXXZ", "void __cdecl foo(void)")]
        [InlineData("?bar@@YAHH@Z", "int __cdecl bar(int)")]
        [InlineData("?bar@Foo@@QEAAXXZ", "public: void __cdecl Foo::bar(void)")]
        public void Demangle_MsvcSymbols(string mangled, string expected)
        {
            Assert.Equal(expected, LlvmDemangler.Demangle(mangled));
        }

        [Fact]
        public void Demangle_Null_ReturnsNull()
        {
            Assert.Null(LlvmDemangler.Demangle(null));
        }

        [Theory]
        [InlineData("")]
        [InlineData("not_a_mangled_name")]
        [InlineData("printf")]
        public void Demangle_InvalidInput_ReturnsNull(string mangled)
        {
            Assert.Null(LlvmDemangler.Demangle(mangled));
        }
    }
}
