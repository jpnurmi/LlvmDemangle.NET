#ifndef LLVM_DEMANGLE_WRAPPER_H
#define LLVM_DEMANGLE_WRAPPER_H

#ifdef _WIN32
#define LLVM_DEMANGLE_EXPORT __declspec(dllexport)
#else
#define LLVM_DEMANGLE_EXPORT __attribute__((visibility("default")))
#endif

#ifdef __cplusplus
extern "C" {
#endif

LLVM_DEMANGLE_EXPORT const char *llvm_demangle(const char *mangled_name);
LLVM_DEMANGLE_EXPORT void llvm_free(const char *ptr);

#ifdef __cplusplus
}
#endif

#endif
