unit untAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StrUtils, Grids, classAtendimento,
  classListaAtendimento, Generics.Collections;

type
  TfrmAtendimento = class(TForm)
    pgControl: TPageControl;
    tabHorario: TTabSheet;
    tabBloco: TTabSheet;
    memoBlocoNotas: TMemo;
    sbtnSalvar: TSpeedButton;
    sbtnLimpar: TSpeedButton;
    fileSaveDialog: TFileSaveDialog;
    edtDataRef: TEdit;
    Label1: TLabel;
    edtHoraInicial: TEdit;
    edtHoraFinal: TEdit;
    sbtnAdicionarHora: TSpeedButton;
    sgridHorarios: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    sbtnAbrirHorario: TSpeedButton;
    sbtnSalvarHorario: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    Label6: TLabel;
    memoDescricao: TMemo;
    procedure sbtnLimparClick(Sender: TObject);
    procedure sbtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtnAdicionarHoraClick(Sender: TObject);
    procedure AtualizarGrid;
  private
    { Private declarations }

    tempListaAtendimento: TclassListaAtendimento;
  public
    { Public declarations }
  end;

var
  frmAtendimento: TfrmAtendimento;

implementation

{$R *.dfm}

procedure TfrmAtendimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Application.MessageBox('Deseja fechar o m�dulo e descartar as informa��es?','CUIDADO!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    Action:= cafree;
    Release;
    frmAtendimento:= nil;
end;

procedure TfrmAtendimento.FormCreate(Sender: TObject);
begin
  tempListaAtendimento:= TclassListaAtendimento.Create;
  edtDataRef.Text:= DateToStr(Date);

  with sgridHorarios do
  begin
    ColCount:= 4;
    RowCount:= 2;

    ColWidths[0]:= 100;
    ColWidths[1]:= 100;
    ColWidths[2]:= 100;
    ColWidths[3]:= 300;

    Cells[0,0]:= 'Data Referencia';
    Cells[1,0]:= 'Hora Inicial';
    Cells[2,0]:= 'Hora Final';
    Cells[3,0]:= 'Descri��o';
  end;
end;

procedure TfrmAtendimento.sbtnAdicionarHoraClick(Sender: TObject);
var
  tempAtendimento: TclassAtendimento;
  dataRefRec: TDate;
  horaInicialRec, horaFinalRec: TTime;
  descricaoRec: String;
begin
  tempAtendimento:= TclassAtendimento.Create;

  dataRefRec:= StrToDate(edtDataRef.Text);
  horaInicialRec:= StrToTime(edtHoraInicial.Text);
  horaFinalRec:= StrToTime(edtHoraFinal.Text);
  descricaoRec:= memoDescricao.Text;

  with tempAtendimento do
  begin
      dataReferencia:= dataRefRec;
      horaInicial:= horaInicialRec;
      horaFinal:= horaFinalRec;
      descricao:= descricaoRec;
  end;

  tempListaAtendimento.Adicionar(tempAtendimento);
  AtualizarGrid;
end;


procedure TfrmAtendimento.AtualizarGrid;
var
  listaAtendimento: TObjectList<TclassAtendimento>;
  atendimento: TclassAtendimento;
  i: integer;
begin
  listaAtendimento:= tempListaAtendimento.RetornarLista;

  i:= 1;
  for atendimento in listaAtendimento do
  begin
    with sgridHorarios do
    begin
      RowCount:= listaAtendimento.Count + 1;

      Cells[0,i]:= datetostr(atendimento.dataReferencia);
      Cells[1,i]:= TimeToStr(atendimento.horaInicial);
      Cells[2,i]:= TimeToStr(atendimento.horaFinal);
      Cells[3,i]:= atendimento.descricao;
      i:= i + 1;
      ShowMessage(FloatToStr(atendimento.horaInicial));
    end;
  end;

end;

//Parte da Aba Bloco de Notas
procedure TfrmAtendimento.sbtnLimparClick(Sender: TObject);
begin
  If Application.MessageBox('Deseja limpar o Bloco de Notas?','Aten��o!',MB_YESNO +
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
