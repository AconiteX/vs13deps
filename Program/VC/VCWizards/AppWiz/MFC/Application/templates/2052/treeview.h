[!if RIBBON_TOOLBAR]
// ��� MFC ʾ��Դ������ʾ���ʹ�� MFC Microsoft Office Fluent �û����� 
// (��Fluent UI��)����ʾ�������ο���
// ���Բ��䡶Microsoft ������ο����� 
// MFC C++ �������渽����ص����ĵ���  
// ���ơ�ʹ�û�ַ� Fluent UI �����������ǵ����ṩ�ġ�  
// ��Ҫ�˽��й� Fluent UI ���ɼƻ�����ϸ��Ϣ�������  
// http://go.microsoft.com/fwlink/?LinkId=238214��
//
// ��Ȩ����(C) Microsoft Corporation
// ��������Ȩ����
[!endif]

// [!output TREE_VIEW_HEADER] : [!output TREE_VIEW_CLASS] ��Ľӿ�
//


#pragma once

class [!output DOC_CLASS];

class [!output TREE_VIEW_CLASS] : public CTreeView
{
protected: // �������л�����
	[!output TREE_VIEW_CLASS]();
	DECLARE_DYNCREATE([!output TREE_VIEW_CLASS])

// ����
public:
	[!output DOC_CLASS]* GetDocument();

// ����
public:

// ��д
	public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
[!if PRINTING]
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnDraw(CDC* pDC);
[!endif]
	virtual void OnInitialUpdate(); // ������һ�ε���

// ʵ��
public:
	virtual ~[!output TREE_VIEW_CLASS]();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ���ɵ���Ϣӳ�亯��
protected:
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // [!output TREE_VIEW_IMPL] �еĵ��԰汾
inline [!output DOC_CLASS]* [!output TREE_VIEW_CLASS]::GetDocument()
   { return reinterpret_cast<[!output DOC_CLASS]*>(m_pDocument); }
#endif
