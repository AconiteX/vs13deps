/*	xmtx.c -- mutex support for VC++ */
#include "xmtx.h"
#include <awint.h>

 #if !_MULTI_THREAD
 #else /* !_MULTI_THREAD */
/* Win32 critical sections are recursive, but
	Win32 does not have once-function */

void  __CLRCALL_PURE_OR_CDECL _Once(_Once_t *_Cntrl, void (*_Func)(void))
	{	/* execute _Func exactly one time */
	_Once_t old;
	if (*_Cntrl == 2)
		;
	else if ((old = _InterlockedExchange(_Cntrl, 1)) == 0)
		{	/* execute _Func, mark as executed */
		_Func();
		*_Cntrl = 2;
		}
	else if (old == 2)
		*_Cntrl = 2;
	else
		while (*_Cntrl != 2)
			__crtSleep(1);
	}

void  __CLRCALL_PURE_OR_CDECL _Mtxinit(_Rmtx *_Mtx)
	{	/* initialize mutex */
	__crtInitializeCriticalSectionEx(_Mtx, 4000, 0);
	}

void  __CLRCALL_PURE_OR_CDECL _Mtxdst(_Rmtx *_Mtx)
	{	/* delete mutex */
	DeleteCriticalSection(_Mtx);
	}

_RELIABILITY_CONTRACT
void  __CLRCALL_PURE_OR_CDECL _Mtxlock(_Rmtx *_Mtx)
	{	/* lock mutex */
#ifdef _M_CEE
	System::Threading::Thread::BeginThreadAffinity();
#endif /* _M_CEE */
	EnterCriticalSection(_Mtx);
	}

_RELIABILITY_CONTRACT
void  __CLRCALL_PURE_OR_CDECL _Mtxunlock(_Rmtx *_Mtx)
	{	/* unlock mutex */
	LeaveCriticalSection(_Mtx);
#ifdef _M_CEE
	System::Threading::Thread::EndThreadAffinity();
#endif /* _M_CEE */
	}
 #endif /* !_MULTI_THREAD */

/*
 * Copyright (c) 1992-2012 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
 V6.00:0009 */
