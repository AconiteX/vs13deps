// [!output IMPL_FILE]: ???? ??????????
//

#include "stdafx.h"
[!if PROJECT_NAME_HEADER]
#include "[!output PROJECT_NAME].h"
[!endif]
#include "[!output HEADER_FILE]"
[!if !MERGE_FILE]

#ifdef _DEBUG
#define new DEBUG_NEW
#endif
[!endif]


// [!output CLASS_NAME]

IMPLEMENT_DYNCREATE([!output CLASS_NAME], [!output BASE_CLASS_SAFE])

[!output CLASS_NAME]::[!output CLASS_NAME]()
{
[!if ACCESSIBILITY]
#ifndef _WIN32_WCE
	EnableActiveAccessibility();
#endif
[!endif]

[!if AUTOMATION || CREATABLE]
	EnableAutomation();
[!endif]
[!if CREATABLE]
	
	// ????? ?????????? ?????? ?????????? ? ??????? ????? ??????? ?????????? ??????? ????????????? OLE, 
	//	??????????? ???????? AfxOleLockApp.
	
	AfxOleLockApp();
[!endif]
}

[!output CLASS_NAME]::~[!output CLASS_NAME]()
{
[!if CREATABLE]
	// ????? ???????? ?????? ??????????, ????? ??? ??????? ???????
	// 	??? ?????? OLE-?????????????, ?????????? ???????? AfxOleUnlockApp.
	
	AfxOleUnlockApp();
[!endif]
}
[!if AUTOMATION || CREATABLE]

void [!output CLASS_NAME]::OnFinalRelease()
{
	// ????? ????? ??????????? ????????? ?????? ?? ?????? ?????????????,
	// ?????????? OnFinalRelease.  ??????? ????? ?????????????
	// ?????? ??????.  ????? ??????? ???????? ?????? ????????
	// ?????????????? ???????, ??????????? ?????? ???????.

	[!output BASE_CLASS_SAFE]::OnFinalRelease();
}
[!endif]

BOOL [!output CLASS_NAME]::OnCreateClient(LPCREATESTRUCT /*lpcs*/, CCreateContext* pContext)
{
	return m_wndSplitter.Create(this,
		2, 2,       // TODO: ???????? ????? ?????, ????????
		CSize(10, 10),  // TODO: ???????? ??????????? ?????? ???????
		pContext);
}

BEGIN_MESSAGE_MAP([!output CLASS_NAME], [!output BASE_CLASS_SAFE])
END_MESSAGE_MAP()
[!if AUTOMATION || CREATABLE]

BEGIN_DISPATCH_MAP([!output CLASS_NAME], [!output BASE_CLASS_SAFE])
END_DISPATCH_MAP()

// ??????????: ?? ???????? ????????? ??? IID_I[!output CLASS_NAME_ROOT], ????? ?????????? ?????????? ? ????? ?????? ????? ????????
//  ?? VBA.  ???? IID ?????? ??????????????? GUID, ?????????? ? 
//  disp-??????????? ? ????? .IDL.

// {[!output DISPIID_REGISTRY_FORMAT]}
static const IID IID_I[!output CLASS_NAME_ROOT] =
[!output DISPIID_STATIC_CONST_GUID_FORMAT];

BEGIN_INTERFACE_MAP([!output CLASS_NAME], [!output BASE_CLASS_SAFE])
	INTERFACE_PART([!output CLASS_NAME], IID_I[!output CLASS_NAME_ROOT], Dispatch)
END_INTERFACE_MAP()
[!endif]
[!if CREATABLE]

// {[!output CLSID_REGISTRY_FORMAT]}
IMPLEMENT_OLECREATE([!output CLASS_NAME], "[!output TYPEID]", [!output CLSID_IMPLEMENT_OLECREATE_FORMAT])
[!endif]


// ??????????? ????????? [!output CLASS_NAME]
