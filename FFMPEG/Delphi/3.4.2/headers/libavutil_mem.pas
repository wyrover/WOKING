(*
 * copyright (c) 2006 Michael Niedermayer <michaelni@gmx.at>
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *)

(**
 * @file
 * @ingroup lavu_mem
 * Memory handling functions
 *)

(*
 * FFVCL - Delphi FFmpeg VCL Components
 * http://www.DelphiFFmpeg.com
 *
 * Original file: libavutil/mem.h
 * Ported by CodeCoolie@CNSW 2008/03/21 -> $Date:: 2018-02-01 #$
 *)

(*
FFmpeg Delphi/Pascal Headers and Examples License Agreement

A modified part of FFVCL - Delphi FFmpeg VCL Components.
Copyright (c) 2008-2018 DelphiFFmpeg.com
All rights reserved.
http://www.DelphiFFmpeg.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

This source code is provided "as is" by DelphiFFmpeg.com without
warranty of any kind, either expressed or implied, including but not
limited to the implied warranties of merchantability and/or fitness
for a particular purpose.

Please also notice the License agreement of FFmpeg libraries.
*)

unit libavutil_mem;

interface

{$I CompilerDefines.inc}

{$IF Defined(BCB)}
uses
  FFTypes;
{$IFEND}

{$I libversion.inc}

(**
 * @addtogroup lavu_mem
 * Utilities for manipulating memory.
 *
 * FFmpeg has several applications of memory that are not required of a typical
 * program. For example, the computing-heavy components like video decoding and
 * encoding can be sped up significantly through the use of aligned memory.
 *
 * However, for each of FFmpeg's applications of memory, there might not be a
 * recognized or standardized API for that specific use. Memory alignment, for
 * instance, varies wildly depending on operating systems, architectures, and
 * compilers. Hence, this component of @ref libavutil is created to make
 * dealing with memory consistently possible on all platforms.
 *
 * @{
 *
 * @defgroup lavu_mem_macros Alignment Macros
 * Helper macros for declaring aligned variables.
 * @{
 *)

(**
 * @def DECLARE_ALIGNED(n,t,v)
 * Declare a variable that is aligned in memory.
 *
 * @code{.c}
 * DECLARE_ALIGNED(16, uint16_t, aligned_int) = 42;
 * DECLARE_ALIGNED(32, uint8_t, aligned_array)[128];
 *
 * // The default-alignment equivalent would be
 * uint16_t aligned_int = 42;
 * uint8_t aligned_array[128];
 * @endcode
 *
 * @param n Minimum alignment in bytes
 * @param t Type of the variable (or array element)
 * @param v Name of the variable
 *)

(**
 * @def DECLARE_ASM_CONST(n,t,v)
 * Declare a static constant aligned variable appropriate for use in inline
 * assembly code.
 *
 * @code{.c}
 * DECLARE_ASM_CONST(16, uint64_t, pw_08) = UINT64_C(0x0008000800080008);
 * @endcode
 *
 * @param n Minimum alignment in bytes
 * @param t Type of the variable (or array element)
 * @param v Name of the variable
 *)

(*
#if defined(__INTEL_COMPILER) && __INTEL_COMPILER < 1110 || defined(__SUNPRO_C)
    #define DECLARE_ALIGNED(n,t,v)      t __attribute__ ((aligned (n))) v
    #define DECLARE_ASM_CONST(n,t,v)    const t __attribute__ ((aligned (n))) v
#elif defined(__TI_COMPILER_VERSION__)
    #define DECLARE_ALIGNED(n,t,v)                      \
        AV_PRAGMA(DATA_ALIGN(v,n))                      \
        t __attribute__((aligned(n))) v
    #define DECLARE_ASM_CONST(n,t,v)                    \
        AV_PRAGMA(DATA_ALIGN(v,n))                      \
        static const t __attribute__((aligned(n))) v
#elif defined(__DJGPP__)
    #define DECLARE_ALIGNED(n,t,v)      t __attribute__ ((aligned (FFMIN(n, 16)))) v
    #define DECLARE_ASM_CONST(n,t,v)    static const t av_used __attribute__ ((aligned (FFMIN(n, 16)))) v
#elif defined(__GNUC__) || defined(__clang__)
    #define DECLARE_ALIGNED(n,t,v)      t __attribute__ ((aligned (n))) v
    #define DECLARE_ASM_CONST(n,t,v)    static const t av_used __attribute__ ((aligned (n))) v
#elif defined(_MSC_VER)
    #define DECLARE_ALIGNED(n,t,v)      __declspec(align(n)) t v
    #define DECLARE_ASM_CONST(n,t,v)    __declspec(align(n)) static const t v
#else
    #define DECLARE_ALIGNED(n,t,v)      t v
    #define DECLARE_ASM_CONST(n,t,v)    static const t v
#endif
*)

(**
 * @}
 *)

(**
 * @defgroup lavu_mem_attrs Function Attributes
 * Function attributes applicable to memory handling functions.
 *
 * These function attributes can help compilers emit more useful warnings, or
 * generate better code.
 * @{
 *)

(**
 * @def av_malloc_attrib
 * Function attribute denoting a malloc-like function.
 *
 * @see <a href="https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-g_t_0040code_007bmalloc_007d-function-attribute-3251">Function attribute `malloc` in GCC's documentation</a>
 *)

(*
#if AV_GCC_VERSION_AT_LEAST(3,1)
    #define av_malloc_attrib __attribute__((__malloc__))
#else
    #define av_malloc_attrib
#endif
*)

(**
 * @def av_alloc_size(...)
 * Function attribute used on a function that allocates memory, whose size is
 * given by the specified parameter(s).
 *
 * @code{.c}
 * void *av_malloc(size_t size) av_alloc_size(1);
 * void *av_calloc(size_t nmemb, size_t size) av_alloc_size(1, 2);
 * @endcode
 *
 * @param ... One or two parameter indexes, separated by a comma
 *
 * @see <a href="https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-g_t_0040code_007balloc_005fsize_007d-function-attribute-3220">Function attribute `alloc_size` in GCC's documentation</a>
 *)

(*
#if AV_GCC_VERSION_AT_LEAST(4,3)
    #define av_alloc_size(...) __attribute__((alloc_size(__VA_ARGS__)))
#else
    #define av_alloc_size(...)
#endif
*)

(**
 * @}
 *)

(**
 * @defgroup lavu_mem_funcs Heap Management
 * Functions responsible for allocating, freeing, and copying memory.
 *
 * All memory allocation functions have a built-in upper limit of `INT_MAX`
 * bytes. This may be changed with av_max_alloc(), although exercise extreme
 * caution when doing so.
 *
 * @{
 *)

(**
 * Allocate a memory block with alignment suitable for all memory accesses
 * (including vectors if available on the CPU).
 *
 * @param size Size in bytes for the memory block to be allocated
 * @return Pointer to the allocated block, or `NULL` if the block cannot
 *         be allocated
 * @see av_mallocz()
 *)
function av_malloc(size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_malloc';

(**
 * Allocate a memory block with alignment suitable for all memory accesses
 * (including vectors if available on the CPU) and zero all the bytes of the
 * block.
 *
 * @param size Size in bytes for the memory block to be allocated
 * @return Pointer to the allocated block, or `NULL` if it cannot be allocated
 * @see av_malloc()
 *)
function av_mallocz(size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_mallocz';

(**
 * Allocate a memory block for an array with av_malloc().
 *
 * The allocated memory will have size `size * nmemb` bytes.
 *
 * @param nmemb Number of element
 * @param size  Size of a single element
 * @return Pointer to the allocated block, or `NULL` if the block cannot
 *         be allocated
 * @see av_malloc()
 *)
(*
av_alloc_size(1, 2) static inline void *av_malloc_array(size_t nmemb, size_t size)
{
    if (size <= 0 || nmemb >= INT_MAX / size)
        return NULL;
    return av_malloc(nmemb * size);
}
*)

(**
 * Allocate a memory block for an array with av_mallocz().
 *
 * The allocated memory will have size `size * nmemb` bytes.
 *
 * @param nmemb Number of elements
 * @param size  Size of the single element
 * @return Pointer to the allocated block, or `NULL` if the block cannot
 *         be allocated
 *
 * @see av_mallocz()
 * @see av_malloc_array()
 *)
(*
av_alloc_size(1, 2) static inline void *av_mallocz_array(size_t nmemb, size_t size)
{
    if (!size || nmemb >= INT_MAX / size)
        return NULL;
    return av_mallocz(nmemb * size);
}
*)

(**
 * Non-inlined equivalent of av_mallocz_array().
 *
 * Created for symmetry with the calloc() C function.
 *)
function av_calloc(nmemb, size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_calloc';

(**
 * Allocate, reallocate, or free a block of memory.
 *
 * If `ptr` is `NULL` and `size` > 0, allocate a new block. If `size` is
 * zero, free the memory block pointed to by `ptr`. Otherwise, expand or
 * shrink that block of memory according to `size`.
 *
 * @param ptr  Pointer to a memory block already allocated with
 *             av_realloc() or `NULL`
 * @param size Size in bytes of the memory block to be allocated or
 *             reallocated
 *
 * @return Pointer to a newly-reallocated block or `NULL` if the block
 *         cannot be reallocated or the function is used to free the memory block
 *
 * @warning Unlike av_malloc(), the returned pointer is not guaranteed to be
 *          correctly aligned.
 * @see av_fast_realloc()
 * @see av_reallocp()
 *)
function av_realloc(ptr: Pointer; size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_realloc';

(**
 * Allocate, reallocate, or free a block of memory through a pointer to a
 * pointer.
 *
 * If `*ptr` is `NULL` and `size` > 0, allocate a new block. If `size` is
 * zero, free the memory block pointed to by `*ptr`. Otherwise, expand or
 * shrink that block of memory according to `size`.
 *
 * @param[in,out] ptr  Pointer to a pointer to a memory block already allocated
 *                     with av_realloc(), or a pointer to `NULL`. The pointer
 *                     is updated on success, or freed on failure.
 * @param[in]     size Size in bytes for the memory block to be allocated or
 *                     reallocated
 *
 * @return Zero on success, an AVERROR error code on failure
 *
 * @warning Unlike av_malloc(), the allocated memory is not guaranteed to be
 *          correctly aligned.
 *)
function av_reallocp(ptr: Pointer; size: Cardinal): Integer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_reallocp';

(**
 * Allocate, reallocate, or free a block of memory.
 *
 * This function does the same thing as av_realloc(), except:
 * - It takes two size arguments and allocates `nelem * elsize` bytes,
 *   after checking the result of the multiplication for integer overflow.
 * - It frees the input block in case of failure, thus avoiding the memory
 *   leak with the classic
 *   @code{.c}
 *   buf = realloc(buf);
 *   if (!buf)
 *       return -1;
 *   @endcode
 *   pattern.
 *)
function av_realloc_f(ptr: Pointer; nelem, elsize: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_realloc_f';

(**
 * Allocate, reallocate, or free an array.
 *
 * If `ptr` is `NULL` and `nmemb` > 0, allocate a new block. If
 * `nmemb` is zero, free the memory block pointed to by `ptr`.
 *
 * @param ptr   Pointer to a memory block already allocated with
 *              av_realloc() or `NULL`
 * @param nmemb Number of elements in the array
 * @param size  Size of the single element of the array
 *
 * @return Pointer to a newly-reallocated block or NULL if the block
 *         cannot be reallocated or the function is used to free the memory block
 *
 * @warning Unlike av_malloc(), the allocated memory is not guaranteed to be
 *          correctly aligned.
 * @see av_reallocp_array()
 *)
function av_realloc_array(ptr: Pointer; nmemb, size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_realloc_array';

(**
 * Allocate, reallocate, or free an array through a pointer to a pointer.
 *
 * If `*ptr` is `NULL` and `nmemb` > 0, allocate a new block. If `nmemb` is
 * zero, free the memory block pointed to by `*ptr`.
 *
 * @param[in,out] ptr   Pointer to a pointer to a memory block already
 *                      allocated with av_realloc(), or a pointer to `NULL`.
 *                      The pointer is updated on success, or freed on failure.
 * @param[in]     nmemb Number of elements
 * @param[in]     size  Size of the single element
 *
 * @return Zero on success, an AVERROR error code on failure
 *
 * @warning Unlike av_malloc(), the allocated memory is not guaranteed to be
 *          correctly aligned.
 *)
function av_reallocp_array(ptr: Pointer; nmemb, size: Cardinal): Integer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_reallocp_array';

(**
 * Reallocate the given buffer if it is not large enough, otherwise do nothing.
 *
 * If the given buffer is `NULL`, then a new uninitialized buffer is allocated.
 *
 * If the given buffer is not large enough, and reallocation fails, `NULL` is
 * returned and `*size` is set to 0, but the original buffer is not changed or
 * freed.
 *
 * A typical use pattern follows:
 *
 * @code{.c}
 * uint8_t *buf = ...;
 * uint8_t *new_buf = av_fast_realloc(buf, &current_size, size_needed);
 * if (!new_buf) {
 *     // Allocation failed; clean up original buffer
 *     av_freep(&buf);
 *     return AVERROR(ENOMEM);
 * }
 * @endcode
 *
 * @param[in,out] ptr      Already allocated buffer, or `NULL`
 * @param[in,out] size     Pointer to current size of buffer `ptr`. `*size` is
 *                         changed to `min_size` in case of success or 0 in
 *                         case of failure
 * @param[in]     min_size New size of buffer `ptr`
 * @return `ptr` if the buffer is large enough, a pointer to newly reallocated
 *         buffer if the buffer was not large enough, or `NULL` in case of
 *         error
 * @see av_realloc()
 * @see av_fast_malloc()
 *)
function av_fast_realloc(ptr: Pointer; size: PCardinal; min_size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_fast_realloc';

(**
 * Allocate a buffer, reusing the given one if large enough.
 *
 * Contrary to av_fast_realloc(), the current buffer contents might not be
 * preserved and on error the old buffer is freed, thus no special handling to
 * avoid memleaks is necessary.
 *
 * `*ptr` is allowed to be `NULL`, in which case allocation always happens if
 * `size_needed` is greater than 0.
 *
 * @code{.c}
 * uint8_t *buf = ...;
 * av_fast_malloc(&buf, &current_size, size_needed);
 * if (!buf) {
 *     // Allocation failed; buf already freed
 *     return AVERROR(ENOMEM);
 * }
 * @endcode
 *
 * @param[in,out] ptr      Pointer to pointer to an already allocated buffer.
 *                         `*ptr` will be overwritten with pointer to new
 *                         buffer on success or `NULL` on failure
 * @param[in,out] size     Pointer to current size of buffer `*ptr`. `*size` is
 *                         changed to `min_size` in case of success or 0 in
 *                         case of failure
 * @param[in]     min_size New size of buffer `*ptr`
 * @see av_realloc()
 * @see av_fast_mallocz()
 *)
procedure av_fast_malloc(ptr: Pointer; size: PCardinal; min_size: Cardinal); cdecl; external AVUTIL_LIBNAME name _PU + 'av_fast_malloc';

(**
 * Allocate and clear a buffer, reusing the given one if large enough.
 *
 * Like av_fast_malloc(), but all newly allocated space is initially cleared.
 * Reused buffer is not cleared.
 *
 * `*ptr` is allowed to be `NULL`, in which case allocation always happens if
 * `size_needed` is greater than 0.
 *
 * @param[in,out] ptr      Pointer to pointer to an already allocated buffer.
 *                         `*ptr` will be overwritten with pointer to new
 *                         buffer on success or `NULL` on failure
 * @param[in,out] size     Pointer to current size of buffer `*ptr`. `*size` is
 *                         changed to `min_size` in case of success or 0 in
 *                         case of failure
 * @param[in]     min_size New size of buffer `*ptr`
 * @see av_fast_malloc()
 *)
procedure av_fast_mallocz(ptr: Pointer; size: PCardinal; min_size: Cardinal); cdecl; external AVUTIL_LIBNAME name _PU + 'av_fast_mallocz';

(**
 * Free a memory block which has been allocated with a function of av_malloc()
 * or av_realloc() family.
 *
 * @param ptr Pointer to the memory block which should be freed.
 *
 * @note `ptr = NULL` is explicitly allowed.
 * @note It is recommended that you use av_freep() instead, to prevent leaving
 *       behind dangling pointers.
 * @see av_freep()
 *)
procedure av_free(ptr: Pointer); cdecl; external AVUTIL_LIBNAME name _PU + 'av_free';

(**
 * Free a memory block which has been allocated with a function of av_malloc()
 * or av_realloc() family, and set the pointer pointing to it to `NULL`.
 *
 * @code{.c}
 * uint8_t *buf = av_malloc(16);
 * av_free(buf);
 * // buf now contains a dangling pointer to freed memory, and accidental
 * // dereference of buf will result in a use-after-free, which may be a
 * // security risk.
 *
 * uint8_t *buf = av_malloc(16);
 * av_freep(&buf);
 * // buf is now NULL, and accidental dereference will only result in a
 * // NULL-pointer dereference.
 * @endcode
 *
 * @param ptr Pointer to the pointer to the memory block which should be freed
 * @note `*ptr = NULL` is safe and leads to no action.
 * @see av_free()
 *)
procedure av_freep(ptr: Pointer); cdecl; external AVUTIL_LIBNAME name _PU + 'av_freep';

(**
 * Duplicate a string.
 *
 * @param s String to be duplicated
 * @return Pointer to a newly-allocated string containing a
 *         copy of `s` or `NULL` if the string cannot be allocated
 * @see av_strndup()
 *)
function av_strdup(const s: PAnsiChar): PAnsiChar; cdecl; external AVUTIL_LIBNAME name _PU + 'av_strdup';

(**
 * Duplicate a substring of a string.
 *
 * @param s   String to be duplicated
 * @param len Maximum length of the resulting string (not counting the
 *            terminating byte)
 * @return Pointer to a newly-allocated string containing a
 *         substring of `s` or `NULL` if the string cannot be allocated
 *)
function av_strndup(const s: PAnsiChar; len: Cardinal): PAnsiChar; cdecl; external AVUTIL_LIBNAME name _PU + 'av_strndup';

(**
 * Duplicate a buffer with av_malloc().
 *
 * @param p    Buffer to be duplicated
 * @param size Size in bytes of the buffer copied
 * @return Pointer to a newly allocated buffer containing a
 *         copy of `p` or `NULL` if the buffer cannot be allocated
 *)
function av_memdup(const p: Pointer; size: Cardinal): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_memdup';

(**
 * Overlapping memcpy() implementation.
 *
 * @param dst  Destination buffer
 * @param back Number of bytes back to start copying (i.e. the initial size of
 *             the overlapping window); must be > 0
 * @param cnt  Number of bytes to copy; must be >= 0
 *
 * @note `cnt > back` is valid, this will copy the bytes we just copied,
 *       thus creating a repeating pattern with a period length of `back`.
 *)
procedure av_memcpy_backptr(dst: PByte; back, cnt: Integer); cdecl; external AVUTIL_LIBNAME name _PU + 'av_memcpy_backptr';

(**
 * @}
 *)

(**
 * @defgroup lavu_mem_dynarray Dynamic Array
 *
 * Utilities to make an array grow when needed.
 *
 * Sometimes, the programmer would want to have an array that can grow when
 * needed. The libavutil dynamic array utilities fill that need.
 *
 * libavutil supports two systems of appending elements onto a dynamically
 * allocated array, the first one storing the pointer to the value in the
 * array, and the second storing the value directly. In both systems, the
 * caller is responsible for maintaining a variable containing the length of
 * the array, as well as freeing of the array after use.
 *
 * The first system stores pointers to values in a block of dynamically
 * allocated memory. Since only pointers are stored, the function does not need
 * to know the size of the type. Both av_dynarray_add() and
 * av_dynarray_add_nofree() implement this system.
 *
 * @code
 * type **array = NULL; //< an array of pointers to values
 * int    nb    = 0;    //< a variable to keep track of the length of the array
 *
 * type to_be_added  = ...;
 * type to_be_added2 = ...;
 *
 * av_dynarray_add(&array, &nb, &to_be_added);
 * if (nb == 0)
 *     return AVERROR(ENOMEM);
 *
 * av_dynarray_add(&array, &nb, &to_be_added2);
 * if (nb == 0)
 *     return AVERROR(ENOMEM);
 *
 * // Now:
 * //  nb           == 2
 * // &to_be_added  == array[0]
 * // &to_be_added2 == array[1]
 *
 * av_freep(&array);
 * @endcode
 *
 * The second system stores the value directly in a block of memory. As a
 * result, the function has to know the size of the type. av_dynarray2_add()
 * implements this mechanism.
 *
 * @code
 * type *array = NULL; //< an array of values
 * int   nb    = 0;    //< a variable to keep track of the length of the array
 *
 * type to_be_added  = ...;
 * type to_be_added2 = ...;
 *
 * type *addr = av_dynarray2_add((void ** )&array, &nb, sizeof( *array), NULL);
 * if (!addr)
 *     return AVERROR(ENOMEM);
 * memcpy(addr, &to_be_added, sizeof(to_be_added));
 *
 * // Shortcut of the above.
 * type *addr = av_dynarray2_add((void ** )&array, &nb, sizeof( *array),
 *                               (const void * )&to_be_added2);
 * if (!addr)
 *     return AVERROR(ENOMEM);
 *
 * // Now:
 * //  nb           == 2
 * //  to_be_added  == array[0]
 * //  to_be_added2 == array[1]
 *
 * av_freep(&array);
 * @endcode
 *
 * @{
 *)

(**
 * Add the pointer to an element to a dynamic array.
 *
 * The array to grow is supposed to be an array of pointers to
 * structures, and the element to add must be a pointer to an already
 * allocated structure.
 *
 * The array is reallocated when its size reaches powers of 2.
 * Therefore, the amortized cost of adding an element is constant.
 *
 * In case of success, the pointer to the array is updated in order to
 * point to the new grown array, and the number pointed to by `nb_ptr`
 * is incremented.
 * In case of failure, the array is freed, `*tab_ptr` is set to `NULL` and
 * `*nb_ptr` is set to 0.
 *
 * @param[in,out] tab_ptr Pointer to the array to grow
 * @param[in,out] nb_ptr  Pointer to the number of elements in the array
 * @param[in]     elem    Element to add
 * @see av_dynarray_add_nofree(), av_dynarray2_add()
 *)
procedure av_dynarray_add(tab_ptr: Pointer; nb_ptr: PInteger; elem: Pointer); cdecl; external AVUTIL_LIBNAME name _PU + 'av_dynarray_add';

(**
 * Add an element to a dynamic array.
 *
 * Function has the same functionality as av_dynarray_add(),
 * but it doesn't free memory on fails. It returns error code
 * instead and leave current buffer untouched.
 *
 * @return >=0 on success, negative otherwise
 * @see av_dynarray_add(), av_dynarray2_add()
 *)
function av_dynarray_add_nofree(tab_ptr: Pointer; nb_ptr: PInteger; elem: Pointer): Integer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_dynarray_add_nofree';

(**
 * Add an element of size `elem_size` to a dynamic array.
 *
 * The array is reallocated when its number of elements reaches powers of 2.
 * Therefore, the amortized cost of adding an element is constant.
 *
 * In case of success, the pointer to the array is updated in order to
 * point to the new grown array, and the number pointed to by `nb_ptr`
 * is incremented.
 * In case of failure, the array is freed, `*tab_ptr` is set to `NULL` and
 * `*nb_ptr` is set to 0.
 *
 * @param[in,out] tab_ptr   Pointer to the array to grow
 * @param[in,out] nb_ptr    Pointer to the number of elements in the array
 * @param[in]     elem_size Size in bytes of an element in the array
 * @param[in]     elem_data Pointer to the data of the element to add. If
 *                          `NULL`, the space of the newly added element is
 *                          allocated but left uninitialized.
 *
 * @return Pointer to the data of the element to copy in the newly allocated
 *         space
 * @see av_dynarray_add(), av_dynarray_add_nofree()
 *)
function av_dynarray2_add(tab_ptr: PPointer; nb_ptr: PInteger; elem_size: Cardinal;
                       const elem_data: PByte): Pointer; cdecl; external AVUTIL_LIBNAME name _PU + 'av_dynarray2_add';

(**
 * @}
 *)

(**
 * @defgroup lavu_mem_misc Miscellaneous Functions
 *
 * Other functions related to memory allocation.
 *
 * @{
 *)

(**
 * Multiply two `size_t` values checking for overflow.
 *
 * @param[in]  a,b Operands of multiplication
 * @param[out] r   Pointer to the result of the operation
 * @return 0 on success, AVERROR(EINVAL) on overflow
 *)
(*
static inline int av_size_mult(size_t a, size_t b, size_t *r)
{
    size_t t = a * b;
    /* Hack inspired from glibc: don't try the division if nelem and elsize
     * are both less than sqrt(SIZE_MAX). */
    if ((a | b) >= ((size_t)1 << (sizeof(size_t) * 4)) && a && t / a != b)
        return AVERROR(EINVAL);
    *r = t;
    return 0;
}
*)

(**
 * Set the maximum size that may be allocated in one block.
 *
 * The value specified with this function is effective for all libavutil's @ref
 * lavu_mem_funcs "heap management functions."
 *
 * By default, the max value is defined as `INT_MAX`.
 *
 * @param max Value to be set as the new maximum size
 *
 * @warning Exercise extreme caution when using this function. Don't touch
 *          this if you do not understand the full consequence of doing so.
 *)
procedure av_max_alloc(max: Cardinal); cdecl; external AVUTIL_LIBNAME name _PU + 'av_max_alloc';

(**
 * @}
 * @}
 *)

(**
 * Allocate a block of size * nmemb bytes with av_malloc().
 * @param nmemb Number of elements
 * @param size Size of the single element
 * @return Pointer to the allocated block, NULL if the block cannot
 * be allocated.
 * @see av_malloc()
 *)
function av_malloc_array(nmemb, size: Cardinal): Pointer; {$IFDEF USE_INLINE}inline;{$ENDIF}

(**
 * Allocate a block of size * nmemb bytes with av_mallocz().
 * @param nmemb Number of elements
 * @param size Size of the single element
 * @return Pointer to the allocated block, NULL if the block cannot
 * be allocated.
 * @see av_mallocz()
 * @see av_malloc_array()
 *)
function av_mallocz_array(nmemb, size: Cardinal): Pointer; {$IFDEF USE_INLINE}inline;{$ENDIF}

implementation


function av_malloc_array(nmemb, size: Cardinal): Pointer;
begin
  if (size <= 0) or (nmemb >= Cardinal(MaxInt) div size) then
    Result := nil
  else
    Result := av_malloc(nmemb * size);
end;

function av_mallocz_array(nmemb, size: Cardinal): Pointer;
begin
  if (size = 0) or (nmemb >= Cardinal(MaxInt) div size) then
    Result := nil
  else
    Result := av_mallocz(nmemb * size);
end;

end.