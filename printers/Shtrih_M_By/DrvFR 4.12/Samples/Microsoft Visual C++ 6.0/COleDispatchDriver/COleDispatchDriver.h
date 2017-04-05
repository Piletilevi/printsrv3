// COleDispatchDriver.h : main header file for the COLEDISPATCHDRIVER application
//

#if !defined(AFX_COLEDISPATCHDRIVER_H__102F6152_5B3C_4E75_A103_B2A64F7EA14B__INCLUDED_)
#define AFX_COLEDISPATCHDRIVER_H__102F6152_5B3C_4E75_A103_B2A64F7EA14B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CCOleDispatchDriverApp:
// See COleDispatchDriver.cpp for the implementation of this class
//

class CCOleDispatchDriverApp : public CWinApp
{
public:
	CCOleDispatchDriverApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCOleDispatchDriverApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCOleDispatchDriverApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLEDISPATCHDRIVER_H__102F6152_5B3C_4E75_A103_B2A64F7EA14B__INCLUDED_)
