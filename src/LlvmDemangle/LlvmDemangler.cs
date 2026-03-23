using System;
using System.Runtime.InteropServices;

namespace LlvmDemangle
{
    public static class LlvmDemangler
    {
        public static string Demangle(string mangledName)
        {
            var ptr = NativeMethods.llvm_demangle(mangledName);
            if (ptr == IntPtr.Zero)
                return null;
            try
            {
                return Marshal.PtrToStringAnsi(ptr);
            }
            finally
            {
                NativeMethods.llvm_free(ptr);
            }
        }

        private static class NativeMethods
        {
            private const string LibraryName = "llvm-demangle";

            [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
            internal static extern IntPtr llvm_demangle(
                [MarshalAs(UnmanagedType.LPStr)] string mangledName);

            [DllImport(LibraryName, CallingConvention = CallingConvention.Cdecl)]
            internal static extern void llvm_free(IntPtr ptr);
        }
    }
}
