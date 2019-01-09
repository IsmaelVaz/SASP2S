unit untInstalacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, ButtonGroup, StdCtrls;

type
  TfrmInstalacao = class(TForm)
    pnMenu: TPanel;
    pnDados: TPanel;
    pnTitulo: TPanel;
    imgLogo: TImage;
    pnConteudo: TPanel;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInstalacao: TfrmInstalacao;

implementation

{$R *.dfm}

procedure TfrmInstalacao.FormCreate(Sender: TObject);
begin
  pnDados.Visible:= false;
end;

end.
