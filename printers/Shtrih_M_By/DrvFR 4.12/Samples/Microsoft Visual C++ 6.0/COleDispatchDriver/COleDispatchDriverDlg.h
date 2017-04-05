// COleDispatchDriverDlg.h : header file
//

#if !defined(AFX_COLEDISPATCHDRIVERDLG_H__B33F113F_E4BA_4830_973F_A7492EC3597A__INCLUDED_)
#define AFX_COLEDISPATCHDRIVERDLG_H__B33F113F_E4BA_4830_973F_A7492EC3597A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CCOleDispatchDriverDlg dialog

class CCOleDispatchDriverDlg : public CDialog
{
// Construction
public:
	CCOleDispatchDriverDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CCOleDispatchDriverDlg)
	enum { IDD = IDD_COLEDISPATCHDRIVER_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCOleDispatchDriverDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CCOleDispatchDriverDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLEDISPATCHDRIVERDLG_H__B33F113F_E4BA_4830_973F_A7492EC3597A__INCLUDED_)
