unit untAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StrUtils;

type
  TfrmAtendimento = class(TForm)
    pgControl: TPageControl;
    tabHorario: TTabSheet;
    tabBloco: TTabSheet;
    memoBlocoNotas: TMemo;
    sbtnSalvar: TSpeedButton;
    sbtnLimpar: TSpeedButton;
    fileSaveDialog: TFileSaveDialog;
    procedure sbtnLimparClick(Sender: TObject);
    procedure sbtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtendimento: TfrmAtendimento;

implementation

{$R *.dfm}

procedure TfrmAtendimento.sbtnLimparClick(Sender: TObject);
begin
  If Application.MessageBox('Deseja limpar o Bloco de Notas?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    memoBlocoNotas.Clear;
end;

procedure TfrmAtendimento.sbtnSalvarClick(Sender: TObject);
var
  arq: TextFile;
  caminho: String;
  i: integer;
begin
  if fileSaveDialog.Execute then
  begin
    caminho:= fileSaveDialog.FileName;
    if not ContainsText(caminho, '.txt') then
       caminho:= Concat(caminho, '.txt');

    AssignFile(arq, caminho);
    Rewrite(arq);

    for i := 0 to memoBlocoNotas.Lines.Count do
      Writeln(arq, memoBlocoNotas.Lines[i]);

    CloseFile(arq);
  end;

end;

end.
