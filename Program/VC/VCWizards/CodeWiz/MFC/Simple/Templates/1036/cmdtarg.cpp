// [!output IMPL_FILE]?: fichier d'impl?mentation
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

[!if CREATABLE]
IMPLEMENT_DYNCREATE([!output CLASS_NAME], [!output BASE_CLASS])
[!else]
IMPLEMENT_DYNAMIC([!output CLASS_NAME], [!output BASE_CLASS])
[!endif]

[!if COLECLIENTITEM]
[!output CLASS_NAME]::[!output CLASS_NAME](COleDocument* pContainerDoc /*= NULL*/)
	: COleClientItem(pContainerDoc)
[!else]
[!if CDOCOBJECTSERVER]
[!output CLASS_NAME]::[!output CLASS_NAME](COleServerDoc* pOwner, LPOLEDOCUMENTSITE pDocSite /*= NULL*/)
	: CDocObjectServer(pOwner, pDocSite)
[!else]
[!if CDOCOBJECTSERVERITEM]
[!output CLASS_NAME]::[!output CLASS_NAME](COleServerDoc* pServerDoc, BOOL bAutoDelete)
	: CDocObjectServerItem(pServerDoc, bAutoDelete)
[!else]

[!output CLASS_NAME]::[!output CLASS_NAME]()
[!endif]
[!endif]
[!endif]
{
[!if AUTOMATION || CREATABLE]
	EnableAutomation();
[!endif]
[!if CREATABLE]
	
	// Afin que l'application continue d'?tre ex?cut?e tant qu'un objet OLE automation 
	//	est actif, le constructeur appelle AfxOleLockApp.
	
	AfxOleLockApp();
[!endif]
}

[!output CLASS_NAME]::~[!output CLASS_NAME]()
{
[!if CREATABLE]
	// Pour mettre fin ? l'application lorsque tous les objets ont ?t? cr??s
	// 	avec OLE automation, le destructeur appelle AfxOleUnlockApp.
	
	AfxOleUnlockApp();
[!endif]
}
[!if AUTOMATION || CREATABLE]


void [!output CLASS_NAME]::OnFinalRelease()
{
	// Lorsque la derni?re r?f?rence pour un objet automation est lib?r?e
	// OnFinalRelease est appel?.  La classe de base supprime automatiquement
	// l'objet.  Un nettoyage suppl?mentaire est requis pour votre
	// objet avant d'appeler la classe de base.

	[!output BASE_CLASS]::OnFinalRelease();
}
[!endif]


BEGIN_MESSAGE_MAP([!output CLASS_NAME], [!output BASE_CLASS])
END_MESSAGE_MAP()

[!if AUTOMATION || CREATABLE]

BEGIN_DISPATCH_MAP([!output CLASS_NAME], [!output BASE_CLASS])
END_DISPATCH_MAP()

// Remarque?: Nous avons ajout? une prise en charge pour IID_I[!output CLASS_NAME_ROOT] afin de prendre en charge les liaisons de type s?curis?
//  ? partir de VBA.  Cet IID doit correspondre au GUID qui est attach? ? 
//  dispinterface dans le fichier .IDL.

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


// Gestionnaires de messages de [!output CLASS_NAME]
