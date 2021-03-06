/***
*mbccpy.c - Copy one character  to another (MBCS)
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       Copy one MBCS character to another (1 or 2 bytes)
*
*******************************************************************************/

#if !defined (_CRT_APP)

#include <mtdll.h>
#include <cruntime.h>
#include <mbdata.h>
#include <mbctype.h>
#include <mbstring.h>
#include <memory.h>
#include <crtdefs.h>
#include <internal.h>
#include <locale.h>
#include <setlocal.h>

/***
* _mbccpy - Copy one character to another (MBCS)
*
*Purpose:
*       Copies exactly one MBCS character from src to dst.  Copies _mbclen(src)
*       bytes from src to dst.
*
*Entry:
*       unsigned char *dst = destination for copy
*       unsigned char *src = source for copy
*
*Exit:
*
*Exceptions:
*       Input parameters are validated. Refer to the validation section of the function.
*
*******************************************************************************/

extern "C" void __cdecl _mbccpy_l(
        unsigned char *dst,
        const unsigned char *src,
        _locale_t plocinfo
        )
{
    /* _mbccpy_s_l sets errno */
    _mbccpy_s_l(dst, 2, NULL, src, plocinfo);
}

extern "C" void (__cdecl _mbccpy)(
        unsigned char *dst,
        const unsigned char *src
        )
{
    _mbccpy_s_l(dst, 2, NULL, src, NULL);
}

#endif  /* !defined (_CRT_APP) */
