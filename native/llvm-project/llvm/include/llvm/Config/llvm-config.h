/*===------- llvm/Config/llvm-config.h - llvm configuration -------*- C -*-===*/
/*                                                                            */
/* Part of the LLVM Project, under the Apache License v2.0 with LLVM          */
/* Exceptions.                                                                */
/* See https://llvm.org/LICENSE.txt for license information.                  */
/* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    */
/*                                                                            */
/*===----------------------------------------------------------------------===*/

/* Minimal llvm-config.h for standalone LLVM Demangle library.
   Generated from llvm-config.h.cmake in llvmorg-22.1.1. */

#ifndef LLVM_CONFIG_H
#define LLVM_CONFIG_H

#define LLVM_VERSION_MAJOR 22
#define LLVM_VERSION_MINOR 1
#define LLVM_VERSION_PATCH 1
#define LLVM_VERSION_STRING "22.1.1"

/* Not building as shared library, so no export annotations needed. */
/* #undef LLVM_ENABLE_LLVM_EXPORT_ANNOTATIONS */

#endif
