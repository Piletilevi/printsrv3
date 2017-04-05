unit fmuTabbedPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  // This
  untPages, ComCtrls;

type
  TfmTabbedPage = class(TPage)
    PageControl: TPageControl;
    procedure PageControlChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdatePage; override;
    procedure UpdateObject; override;
  end;

var
  fmTabbedPage: TfmTabbedPage;

implementation

{$R *.dfm}

{ TfmTabbedPage }

// ѕереключились на новую страницу
procedure TfmTabbedPage.PageControlChange(Sender: TObject);
begin
  UpdatePage;
end;

// ”шли со старой страницы
procedure TfmTabbedPage.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  UpdateObject;
  AllowChange := True;
end;

procedure TfmTabbedPage.UpdateObject;
begin
  if Assigned(PageControl.ActivePage) then
    if PageControl.ActivePage.ControlCount > 0 then
      if PageControl.ActivePage.Controls[0] is TPage then
      begin
        TPage(PageControl.ActivePage.Controls[0]).UpdateObject;
      end;
end;

procedure TfmTabbedPage.UpdatePage;
begin
  if Assigned(PageControl.ActivePage) then
    if PageControl.ActivePage.ControlCount > 0 then
      if PageControl.ActivePage.Controls[0] is TPage then
      begin
        TPage(PageControl.ActivePage.Controls[0]).UpdatePage;
      end;
end;

end.
