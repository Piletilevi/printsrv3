unit fmuEJOperations;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls, Buttons,
  Graphics,
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmEJOperations }

  TfmEJOperations = class(TPage)
    grpActivization: TGroupBox;
    btnEKLZActivization: TButton;
    btnEKLZActivizationResult: TButton;
    grpArchive: TGroupBox;
    btnInitEKLZArchive: TButton;
    btnCloseEKLZArchive: TButton;
    btnTestEKLZArchiveIntegrity: TButton;
    grpInterrupt: TGroupBox;
    btnEKLZInterrupt: TBitBtn;
    grpResultCode: TGroupBox;
    btnSetEKLZResultCode: TButton;
    lblEKLZResultCode: TLabel;
    seEKLZResultCode: TSpinEdit;
    procedure btnInitEKLZArchiveClick(Sender: TObject);
    procedure btnEKLZActivizationClick(Sender: TObject);
    procedure btnEKLZActivizationResultClick(Sender: TObject);
    procedure btnCloseEKLZArchiveClick(Sender: TObject);
    procedure btnTestEKLZArchiveIntegrityClick(Sender: TObject);
    procedure btnEKLZInterruptClick(Sender: TObject);
    procedure btnSetEKLZResultCodeClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

resourcestring
  SEJActivationConfirmation = 'Вы уверены что хотите активизировать ЭКЛЗ?';
  SEJCloseArchiveConfirmation = 'Вы уверены что хотите закрыть архив ЭКЛЗ?';

{ TfmEJOperations }

procedure TfmEJOperations.btnInitEKLZArchiveClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.InitEKLZArchive;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJOperations.btnEKLZActivizationClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar(SEJActivationConfirmation),
    PChar(Application.Title), MB_OKCANCEL or MB_DEFBUTTON2 or
    MB_ICONWARNING)=ID_OK then
  begin
    EnableButtons(False);
    try
      Driver.EKLZActivization;
    finally
      EnableButtons(True);
    end;
  end;
end;

procedure TfmEJOperations.btnEKLZActivizationResultClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.EKLZActivizationResult;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJOperations.btnCloseEKLZArchiveClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar(SEJCloseArchiveConfirmation),
    PChar(Application.Title), MB_OKCANCEL or MB_DEFBUTTON2 or
    MB_ICONWARNING) = ID_OK then
  begin
    EnableButtons(False);
    try
      Driver.CloseEKLZArchive;
    finally
      EnableButtons(True);
    end;
  end;
end;

procedure TfmEJOperations.btnTestEKLZArchiveIntegrityClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.TestEKLZArchiveIntegrity;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJOperations.btnEKLZInterruptClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.EKLZInterrupt;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJOperations.btnSetEKLZResultCodeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.EKLZResultCode := seEKLZResultCode.Value;
    Driver.SetEKLZResultCode;
  finally
    EnableButtons(True);
  end;
end;

end.
