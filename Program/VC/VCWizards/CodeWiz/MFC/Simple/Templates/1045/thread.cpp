// [!output IMPL_FILE]: plik implementacji
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

IMPLEMENT_DYNCREATE([!output CLASS_NAME], [!output BASE_CLASS])

[!output CLASS_NAME]::[!output CLASS_NAME]()
{
[!if AUTOMATION || CREATABLE]
	EnableAutomation();
[!endif]
[!if CREATABLE]
	
	// Aby aplikacja by?a uruchomiona tak d?ugo, jak obiekt automatyzacji OLE 
	//	jest aktywny, konstruktor wywo?uje metod? AfxOleLockApp.
	
	AfxOleLockApp();
[!endif]
}

[!output CLASS_NAME]::~[!output CLASS_NAME]()
{
[!if CREATABLE]
	// Aby zako?czy? aplikacj?, gdy wszystkie obiekty stworzone za pomoc?
	// 	automatyzacji OLE, destruktor wywo?a metod? AfxOleUnlockApp.
	
	AfxOleUnlockApp();
[!endif]
}
[!if AUTOMATION || CREATABLE]


void [!output CLASS_NAME]::OnFinalRelease()
{
	// Gdy ostatnie odwo?anie do obiektu automatyzacji zostanie zwolnione,
	// wywo?ywana jest metoda OnFinalRelease.  Klasa podstawowa zostanie automatycznie
	// usuwa obiekt.  Dodaj dodatkowe oczyszczanie wymagane dla
	// obiektu, przed wywo?aniem klasy podstawowej.

	[!output BASE_CLASS]::OnFinalRelease();
}
[!endif]

BOOL [!output CLASS_NAME]::InitInstance()
{
	// TODO: W tym miejscu wykonaj wszelkie inicjacje na w?tek
	return TRUE;
}

int [!output CLASS_NAME]::ExitInstance()
{
	// TODO: W tym miejscu wykonaj wszelkie oczyszczanie na w?tek
	return [!output BASE_CLASS]::ExitInstance();
}

BEGIN_MESSAGE_MAP([!output CLASS_NAME], [!output BASE_CLASS])
END_MESSAGE_MAP()
[!if AUTOMATION || CREATABLE]

BEGIN_DISPATCH_MAP([!output CLASS_NAME], [!output BASE_CLASS])
END_DISPATCH_MAP()

// Uwaga: Zosta?a dodana obs?uga IID_I[!output CLASS_NAME_ROOT], aby umo?liwi? wi?zanie bezpieczne pod wzgl?dem typu
//  z j?zyka VBA.  Identyfikator IID musi by? zgodny z identyfikatorem GUID, kt?ry jest do??czony do 
//  instrukcji dispinterface w pliku .IDL.

// {[!output DISPIID_REGISTRY_FORMAT]}
static const IID IID_I[!output CLASS_NAME_ROOT] =
[!output DISPIID_STATIC_CONST_GUID_FORMAT];

BEGIN_INTERFACE_MAP([!output CLASS_NAME], [!output BASE_CLASS])
	INTERFACE_PART([!output CLASS_NAME], IID_I[!output CLASS_NAME_ROOT], Dispatch)
END_INTERFACE_MAP()
[!endif]
[!if CREATABLE]

// {[!output CLSID_REGISTRY_FORMAT]}
IMPLEMENT_OLECREATE_FLAGS([!output CLASS_NAME], "[!output TYPEID]", afxRegApartmentThreading, [!output CLSID_IMPLEMENT_OLECREATE_FORMAT])
[!endif]


// Obs?ugi wiadomo?ci [!output CLASS_NAME]
