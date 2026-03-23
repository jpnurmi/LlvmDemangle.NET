using LlvmDemangle;

int failures = 0;

void Assert(string label, string? actual, string? expected)
{
    if (actual != expected)
    {
        Console.Error.WriteLine($"FAIL {label}: expected '{expected}', got '{actual}'");
        failures++;
    }
    else
    {
        Console.WriteLine($"PASS {label}: '{actual}'");
    }
}

Assert("Itanium", LlvmDemangler.Demangle("_Z3foov"), "foo()");
Assert("MSVC", LlvmDemangler.Demangle("?foo@@YAXXZ"), "void __cdecl foo(void)");
Assert("Invalid", LlvmDemangler.Demangle("not_mangled"), null);

return failures;
