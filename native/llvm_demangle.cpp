#include "llvm_demangle.h"
#include "llvm/Demangle/Demangle.h"
#include <cstdlib>
#include <cstring>

extern "C" {

const char *llvm_demangle(const char *mangled_name) {
    if (!mangled_name)
        return nullptr;
    std::string result = llvm::demangle(mangled_name);
    if (result == mangled_name)
        return nullptr;
    return strdup(result.c_str());
}

void llvm_free(const char *ptr) {
    free(const_cast<char *>(ptr));
}

}
