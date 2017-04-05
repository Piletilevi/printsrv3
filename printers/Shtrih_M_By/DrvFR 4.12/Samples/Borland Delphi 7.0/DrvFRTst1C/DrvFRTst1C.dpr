program DrvFRTst1C;

uses
  Forms,
  VLEUtil in 'Units\VLEUtil.pas',
  Driver1C10 in 'Units\Driver1C10.pas',
  fmuMain in 'FMU\fmuMain.pas' {fmMain},
  OleArray1C in 'Units\OleArray1C.pas' {Array1C: CoClass},
  DrvFRTst1C_TLB in 'DrvFRTst1C_TLB.pas',
  LanguageExtender in 'Units\LanguageExtender.pas',
  Driver1C11 in 'Units\Driver1C11.pas',
  untTypes in 'Units\untTypes.pas',
  Driver1C in 'Units\Driver1C.pas',
  RegExpr in '..\TstShared\RegExpr.pas',
  LogFile in '..\TstShared\LogFile.pas',
  BaseForm in '..\TstShared\BaseForm.pas',
  DrvFRLib_TLB in '..\TstShared\DrvFRLib_TLB.pas',
  SMDrvFR1CLib_TLB in '..\TstShared\SMDrvFR1CLib_TLB.pas',
  StringUtils in '..\TstShared\StringUtils.pas',
  DriverTypes in '..\TstShared\DriverTypes.pas',
  GlobalConst in '..\TstShared\GlobalConst.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
