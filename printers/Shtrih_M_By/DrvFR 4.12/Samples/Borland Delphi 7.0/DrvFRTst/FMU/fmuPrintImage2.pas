unit fmuPrintImage2;

interface

uses
  // VCL
  Windows, ExtDlgs, Dialogs, ComCtrls, ExtCtrls, Controls, StdCtrls,
  Classes, SysUtils, Graphics, Forms, Buttons,
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmPrintImage2 }

  TfmPrintImage2 = class(TPage)
    OpenPictureDialog: TOpenPictureDialog;
    GroupBox1: TGroupBox;
    btnLoad: TButton;
    pnlImage: TPanel;
    Image: TImage;
    btnOpen: TBitBtn;
    btnDraw: TButton;
    btnDrawEx: TButton;
    lblFirstLineNumber: TLabel;
    lblLastLineNumber: TLabel;
    lblFileName: TLabel;
    edtFileName: TEdit;
    chbCenterImage: TCheckBox;
    chbShowProgress: TCheckBox;
    seFirstLineNumber: TSpinEdit;
    seLastLineNumber: TSpinEdit;
    procedure btnDrawClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnDrawExClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmPrintImage2 }

procedure TfmPrintImage2.btnOpenClick(Sender: TObject);
begin
  OpenPictureDialog.FileName := edtFileName.Text;
  if OpenPictureDialog.Execute then
  begin
    Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    edtFileName.Text := OpenPictureDialog.FileName;
  end;
end;

procedure TfmPrintImage2.btnLoadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ShowProgress := chbShowProgress.Checked;
    Driver.CenterImage := chbCenterImage.Checked;
    Driver.FileName := edtFileName.Text;
    Driver.LoadImage;
    seFirstLineNumber.Value := Driver.FirstLineNumber;
    seLastLineNumber.Value := Driver.LastLineNumber;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintImage2.btnDrawClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.FirstLineNumber := seFirstLineNumber.Value;
    Driver.LastLineNumber := seLastLineNumber.Value;
    Driver.Draw;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintImage2.btnDrawExClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.FirstLineNumber := seFirstLineNumber.Value;
    Driver.LastLineNumber := seLastLineNumber.Value;
    Driver.DrawEx;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintImage2.FormCreate(Sender: TObject);
begin
  OpenPictureDialog.InitialDir := ExtractFilePath(ParamStr(0));
end;

end.
