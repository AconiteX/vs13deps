#pragma once

#ifdef _WIN32_WCE
#error "CDHtmlDialog ?? ?????????????? ? Windows CE."
#endif 

// ?????????? ???? [!output CLASS_NAME]

class [!output CLASS_NAME] : public CDHtmlDialog
{
	DECLARE_DYNCREATE([!output CLASS_NAME])

public:
	[!output CLASS_NAME](CWnd* pParent = NULL);   // ??????????? ???????????
	virtual ~[!output CLASS_NAME]();
// ???????????????
[!if AUTOMATION || CREATABLE]

	virtual void OnFinalRelease();
[!endif]
	HRESULT OnButtonOK(IHTMLElement *pElement);
	HRESULT OnButtonCancel(IHTMLElement *pElement);

// ?????? ??????????? ????
	enum { IDD = [!output IDD_DIALOG], IDH = [!output HTML_ID] };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // ????????? DDX/DDV
	virtual BOOL OnInitDialog();

	DECLARE_MESSAGE_MAP()
	DECLARE_DHTML_EVENT_MAP()
[!if CREATABLE]
	DECLARE_OLECREATE([!output CLASS_NAME])
[!endif]
[!if AUTOMATION || CREATABLE]
	DECLARE_DISPATCH_MAP()
	DECLARE_INTERFACE_MAP()
[!endif]
};
