/* _FDnorm function -- IEEE 754 version */
#include "xmath.h"
_C_STD_BEGIN

_CRTIMP2_PURE short __CLRCALL_PURE_OR_CDECL _FDnorm(_Fval *ps)
	{	/* normalize float fraction */
	short xchar;
	unsigned short sign = (unsigned short)(ps->_Sh[_F0] & _FSIGN);

	xchar = 1;
	if ((ps->_Sh[_F0] &= _FFRAC) != 0 || ps->_Sh[_F1])
		{	/* nonzero, scale */
		if (ps->_Sh[_F0] == 0)
			ps->_Sh[_F0] = ps->_Sh[_F1], ps->_Sh[_F1] = 0, xchar -= 16;
		for (; ps->_Sh[_F0] < 1 << _FOFF; --xchar)
			{	/* shift left by 1 */
			ps->_Sh[_F0] = (unsigned short)(ps->_Sh[_F0] << 1 | ps->_Sh[_F1] >> 15);
			ps->_Sh[_F1] <<= 1;
			}
		for (; 1 << (_FOFF + 1) <= ps->_Sh[_F0]; ++xchar)
			{	/* shift right by 1 */
			ps->_Sh[_F1] = (unsigned short)(ps->_Sh[_F1] >> 1 | ps->_Sh[_F0] << 15);
			ps->_Sh[_F0] >>= 1;
			}
		ps->_Sh[_F0] &= _FFRAC;
		}
	ps->_Sh[_F0] |= sign;
	return (xchar);
	}
_C_STD_END

/*
 * Copyright (c) 1992-2007 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
 V5.03:0009 */
