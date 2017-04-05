unit DrvFRTst1C_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 19.11.2013 13:35:31 from Type Library described below.

// ************************************************************************  //
// Type Lib: I:\Projects\DrvFRTrunk\Samples\Delphi 7\DrvFRTst1C\DrvFRTst1C.tlb (1)
// LIBID: {388D6434-A3BD-4B7C-ABA2-A9C024BFDE5D}
// LCID: 0
// Helpfile: 
// HelpString: Test1Cst Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DrvFRTst1CMajorVersion = 1;
  DrvFRTst1CMinorVersion = 0;

  LIBID_DrvFRTst1C: TGUID = '{388D6434-A3BD-4B7C-ABA2-A9C024BFDE5D}';

  IID_IArray1C: TGUID = '{0A516895-E9EB-40F0-8CD1-8F3E6155DA50}';
  CLASS_Array1C: TGUID = '{7D118674-0B31-4E2D-AB8D-B2F551156694}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IArray1C = interface;
  IArray1CDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Array1C = IArray1C;


// *********************************************************************//
// Interface: IArray1C
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0A516895-E9EB-40F0-8CD1-8F3E6155DA50}
// *********************************************************************//
  IArray1C = interface(IDispatch)
    ['{0A516895-E9EB-40F0-8CD1-8F3E6155DA50}']
    function Get(Index: Integer): OleVariant; safecall;
    procedure Set_(Index: Integer; Value: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  IArray1CDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0A516895-E9EB-40F0-8CD1-8F3E6155DA50}
// *********************************************************************//
  IArray1CDisp = dispinterface
    ['{0A516895-E9EB-40F0-8CD1-8F3E6155DA50}']
    function Get(Index: Integer): OleVariant; dispid 201;
    procedure Set_(Index: Integer; Value: OleVariant); dispid 202;
  end;

// *********************************************************************//
// The Class CoArray1C provides a Create and CreateRemote method to          
// create instances of the default interface IArray1C exposed by              
// the CoClass Array1C. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoArray1C = class
    class function Create: IArray1C;
    class function CreateRemote(const MachineName: string): IArray1C;
  end;

implementation

uses ComObj;

class function CoArray1C.Create: IArray1C;
begin
  Result := CreateComObject(CLASS_Array1C) as IArray1C;
end;

class function CoArray1C.CreateRemote(const MachineName: string): IArray1C;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Array1C) as IArray1C;
end;

end.
