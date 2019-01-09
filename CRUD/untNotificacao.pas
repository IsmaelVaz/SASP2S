unit untNotificacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, ComCtrls, ToolWin, ImgList;

type
  TfrmNotificacao = class(TForm)
    pnGeral: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    cmdInserir: TToolButton;
    ImageList1: TImageList;
    cmdExcluir: TToolButton;
    cmdEditar: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotificacao: TfrmNotificacao;

implementation

{$R *.dfm}

end.
