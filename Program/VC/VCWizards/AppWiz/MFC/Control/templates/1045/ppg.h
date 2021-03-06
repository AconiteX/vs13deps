#pragma once

// [!output PROPERTY_PAGE_HEADER]: Deklaracja klasy strony właściwości [!output PROPERTY_PAGE_CLASS].


// [!output PROPERTY_PAGE_CLASS]: Aby uzyskać implementację, zobacz [!output PROPERTY_PAGE_IMPL].

class [!output PROPERTY_PAGE_CLASS] : public COlePropertyPage
{
	DECLARE_DYNCREATE([!output PROPERTY_PAGE_CLASS])
	DECLARE_OLECREATE_EX([!output PROPERTY_PAGE_CLASS])

// Konstruktor
public:
	[!output PROPERTY_PAGE_CLASS]();

// Dane okna dialogowego
	enum { IDD = IDD_PROPPAGE_[!output UPPER_CASE_SAFE_PROJECT_IDENTIFIER_NAME] };

// Implementacja
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // obsługa DDX/DDV

// Mapy wiadomości
protected:
	DECLARE_MESSAGE_MAP()
};

