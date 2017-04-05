unit fmuTestEncoding;

interface

uses
  // VCL
  Forms, ComCtrls, StdCtrls, Controls, ExtCtrls, Classes, SysUtils, Buttons,
  Graphics, Dialogs,
  // This
  untPages, untUtil, untDriver, DrvFRLib_TLB, Spin;

type
  { TfmTestEncoding }

  TfmTestEncoding = class(TPage)
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    lblStrCount: TLabel;
    lblText: TLabel;
    Memo: TMemo;
    lblStrCount_: TLabel;
    btnPrint: TBitBtn;
    btnStop: TButton;
    btnOpen: TBitBtn;
    btnSave: TBitBtn;
    edtFontCodepage: TButton;
    btnArmenianText: TButton;
    edtEcrCodePage: TButton; 
    btnFont1: TButton;
    FontDialog: TFontDialog;
    seFontType: TSpinEdit;
    lblFontType: TLabel;
    procedure btnPrintClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure edtFontCodepageClick(Sender: TObject);
    procedure btnArmenianTextClick(Sender: TObject);
    procedure btnFont1Click(Sender: TObject);
    procedure edtEcrCodePageClick(Sender: TObject);
  private
    FStop: Boolean;
    procedure EnableButtons2;
  public
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

{ TfmPrintText }

procedure TfmTestEncoding.btnPrintClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.FontType := seFontType.Value;
    Driver.UseReceiptRibbon := True;
    Driver.UseJournalRibbon := True;
    Driver.UseSlipDocument := True;
    FStop := False;
    btnStop.Enabled := True;
    for i := 0 to Memo.Lines.Count-1 do
    begin
      if FStop then Break;
      Driver.StringForPrinting := Memo.Lines[i];
      Check(Driver.PrintStringWithFont);
      Application.ProcessMessages;
    end;
  finally
    EnableButtons2;
  end;
end;

procedure TfmTestEncoding.btnOpenClick(Sender: TObject);
begin
  if not dlgOpen.Execute then
    Exit;
  Memo.Lines.LoadFromFile(dlgOpen.FileName);
end;

procedure TfmTestEncoding.btnSaveClick(Sender: TObject);
begin
  if not dlgSave.Execute then
    Exit;
  Memo.Lines.SaveToFile(dlgSave.FileName);  
end;

procedure TfmTestEncoding.Initialize;
begin
//  
end;

procedure TfmTestEncoding.MemoChange(Sender: TObject);
begin
  lblStrCount.Caption := IntToStr(Memo.Lines.Count);
end;

procedure TfmTestEncoding.FormShow(Sender: TObject);
begin
  MemoChange(Self);
end;

procedure TfmTestEncoding.btnStopClick(Sender: TObject);
begin
  FStop := True;
end;

procedure TfmTestEncoding.EnableButtons2;
begin
  EnableButtons(True);
  btnStop.Enabled := False;
end;

procedure TfmTestEncoding.edtFontCodepageClick(Sender: TObject);
var
  Line: WideString;
  Code: Integer;
  i, j: Integer;
begin
  Memo.Clear;
  Code := 0;
  for i := 0 to 15 do
  begin
    Line := '';
    for j := 1 to 16 do
    begin
      Line := Line + Chr(Code);
      Inc(Code);
    end;
    Line := Format('0x%.2x %s', [i*16, Line]);
    Memo.Lines.Add(Line);
  end;
end;

procedure TfmTestEncoding.btnArmenianTextClick(Sender: TObject);
var
  Code: Word;
  S: WideString;
  Line: WideString;
begin
  Memo.Clear;
  // 0x0530 .. 0x058F
  for Code := $0530 to $058F do
    S := S + WideChar(Code);

  while Length(S) > 0 do
  begin
    Line := Copy(S, 1, 8);
    Code := Ord(Line[1]);
    Line := WideFormat('0x%.4X: ', [Code]) + Line;
    Memo.Lines.Add(Line);
    S := Copy(S, 9, Length(S));
  end;
end;

procedure TfmTestEncoding.btnFont1Click(Sender: TObject);
begin
  FontDialog.Font := Memo.Font;
  if FontDialog.Execute then
    Memo.Font := FontDialog.Font;
end;

procedure TfmTestEncoding.edtEcrCodePageClick(Sender: TObject);
var
  Line: WideString;
  Code: Integer;
  i, j: Integer;
begin
  Memo.Clear;
  Code := 0;
  for i := 0 to 31 do
  begin
    Line := '';
    for j := 1 to 8 do
    begin
      Line := Line + Format('&#%d;', [Code]);
      Inc(Code);
    end;
    Line := Format('0x%.2x %s', [i*8, Line]);
    Memo.Lines.Add(Line);
  end;
end;

end.
