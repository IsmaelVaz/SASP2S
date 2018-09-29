unit untAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StrUtils, Grids, classAtendimento,
  classListaAtendimento, Generics.Collections, xmldom, XMLIntf, msxmldom, XMLDoc,
  Menus;

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
    sbtnExcluirSel: TSpeedButton;
    Label6: TLabel;
    memoDescricao: TMemo;
    xmlDoc: TXMLDocument;
    fileOpenDialog: TFileOpenDialog;
    ckbLancadoHD: TCheckBox;
    PopupMenu1: TPopupMenu;
    Marcarcomolanado1: TMenuItem;
    Editar1: TMenuItem;
    procedure sbtnLimparClick(Sender: TObject);
    procedure sbtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtnAdicionarHoraClick(Sender: TObject);
    procedure edtHoraInicialKeyPress(Sender: TObject; var Key: Char);
    procedure edtHoraFinalKeyPress(Sender: TObject; var Key: Char);
    procedure sbtnSalvarHorarioClick(Sender: TObject);
    procedure sgridHorariosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sbtnExcluirSelClick(Sender: TObject);
    procedure sbtnAbrirHorarioClick(Sender: TObject);
    procedure sgridHorariosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    procedure AdicionarHora(tempAtendimento: TclassAtendimento);
    procedure AdicionarHoraFaltante();
    procedure LimparCaixasTexto();
    procedure AtualizarGrid;
    function ValidarHora(horaEnviada: String):boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sgridHorariosMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
  private
    { Private declarations }

    tempLstAtendCompleto, tempListaAtendimento: TclassListaAtendimento;
    linhaSelecionadaGrid: Integer;

  public
    { Public declarations }

  end;

var
  frmAtendimento: TfrmAtendimento;

implementation

{$R *.dfm}

procedure TfrmAtendimento.AdicionarHora(tempAtendimento: TclassAtendimento);
begin
     tempListaAtendimento.Adicionar(tempAtendimento);

     AdicionarHoraFaltante;
     AtualizarGrid;
     LimparCaixasTexto;
end;

procedure TfrmAtendimento.AdicionarHoraFaltante();
var
  listaAtendimentoReal: TObjectList<TclassAtendimento>;
  atendimentoReal, proxAtendimento, atendimentoFaltante: TclassAtendimento;
begin
  listaAtendimentoReal:= tempListaAtendimento.RetornarLista;
  tempLstAtendCompleto.Free;
  tempLstAtendCompleto:= TclassListaAtendimento.Create;
  for atendimentoReal in listaAtendimentoReal do
  begin
    if (listaAtendimentoReal.Count > 1) and not(atendimentoReal.Equals(listaAtendimentoReal.Last)) then
    begin
      if not(atendimentoReal.Equals(listaAtendimentoReal.Last)) then
      begin
        proxAtendimento:= listaAtendimentoReal.Items[listaAtendimentoReal.IndexOf(atendimentoReal)+1];

        if timetostr(atendimentoReal.horaFinal) <> (timetostr(proxAtendimento.horaInicial)) then
        begin
            atendimentoFaltante:= TclassAtendimento.Create;
            tempLstAtendCompleto.Adicionar(atendimentoReal);
            with atendimentoFaltante do
            begin
                dataReferencia:= atendimentoReal.dataReferencia;
                horaInicial:= atendimentoReal.horaFinal;
                horaFinal:= proxAtendimento.horaInicial;
                descricao:='';
                quemInseriu:= false;
                lancadoHD:= false;
            end;
            tempLstAtendCompleto.Adicionar(atendimentoFaltante);
            //atendimentoFaltante.Free;
        end
        else
        begin
           tempLstAtendCompleto.Adicionar(atendimentoReal);
        end;
      end;
    end
    else
    begin
       tempLstAtendCompleto.Adicionar(atendimentoReal);
    end;
  end;
end;

procedure TfrmAtendimento.AtualizarGrid;
var
  listaAtendimento: TObjectList<TclassAtendimento>;
  atendimento: TclassAtendimento;
  i: integer;
  hora: string;
begin
    //listaAtendimento:= tempListaAtendimento.RetornarLista;
    listaAtendimento:= tempLstAtendCompleto.RetornarLista;
  if listaAtendimento.Count > 0 then
  begin
    i:= 1;
    for atendimento in listaAtendimento do
    begin
      with sgridHorarios do
      begin
        RowCount:= listaAtendimento.Count + 1;

        Cells[0,i]:= IntToStr(atendimento.oid);
        Cells[1,i]:= datetostr(atendimento.dataReferencia);
        Cells[2,i]:= TimeToStr(atendimento.horaInicial);
        Cells[3,i]:= TimeToStr(atendimento.horaFinal);
        hora:=TimeToStr(atendimento.horaFinal - atendimento.horaInicial);
        Cells[4,i]:= IntToStr((StrToInt(Copy(hora,1,2))*60) + (StrToInt(Copy(hora,4,2))));
        Cells[5,i]:= atendimento.descricao;
        case atendimento.lancadoHD of
          true: Cells[6,i]:= 'SIM';
          false: Cells[6,i]:= 'NÃO';
        end;
        case atendimento.quemInseriu of
          true: Cells[7,i]:= 'NÃO';
          false: Cells[7,i]:= 'SIM';
        end;

        i:= i + 1;
      end;
    end;
  end
  else
  begin
    with sgridHorarios do
      begin
        RowCount:= 2;

        Cells[0,1]:= '';
        Cells[1,1]:= '';
        Cells[2,1]:= '';
        Cells[3,1]:= '';
        Cells[4,1]:= '';

      end;
  end;


end;

function TfrmAtendimento.ValidarHora(horaEnviada: String):boolean;
var
  horas, minutos: integer;

begin
  try
    horas:= StrToInt(Copy(horaEnviada, 1, 2));
    minutos:= StrToInt(Copy(horaEnviada, 4, 5));

    if (horas <= 23) and (horas > 0) and (minutos <= 59) and (minutos >= 0) then
      result:= true
    else
      result:= false;
  except
    result:= false;
  end;

end;

procedure TfrmAtendimento.LimparCaixasTexto();
begin
  edtHoraInicial.Clear;
  edtHoraFinal.Clear;
  memoDescricao.Lines.Clear;
  edtHoraInicial.SetFocus;
  ckbLancadoHD.Checked:= false;
end;

procedure TfrmAtendimento.FormCreate(Sender: TObject);
begin
  tempListaAtendimento:= TclassListaAtendimento.Create;
  tempLstAtendCompleto:=TclassListaAtendimento.Create;

  edtDataRef.Text:= DateToStr(Date);
  linhaSelecionadaGrid:= 0;

  with sgridHorarios do
  begin
    ColCount:= 8;
    RowCount:= 2;

    ColWidths[0]:= 50;
    ColWidths[1]:= 100;
    ColWidths[2]:= 100;
    ColWidths[3]:= 100;
    ColWidths[4]:= 50;
    ColWidths[5]:= 300;
    ColWidths[6]:= 70;
    ColWidths[7]:= 70;

    Cells[0,0]:= 'Oid';
    Cells[1,0]:= 'Data Referencia';
    Cells[2,0]:= 'Hora Inicial';
    Cells[3,0]:= 'Hora Final';
    Cells[4,0]:= 'Minutos';
    Cells[5,0]:= 'Descrição';
    Cells[6,0]:= 'HD';
    Cells[7,0]:= 'Falta?';
  end;
end;

procedure TfrmAtendimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
     sbtnAdicionarHora.Click;
  end;

end;

procedure TfrmAtendimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Application.MessageBox('Deseja fechar o módulo e descartar as informações?','CUIDADO!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    Action:= cafree;
    Release;
    frmAtendimento:= nil;
end;

procedure TfrmAtendimento.sbtnAbrirHorarioClick(Sender: TObject);
var
  i:integer;
  loadAtendimento: TclassAtendimento;
begin
  If Application.MessageBox('Deseja descartar os Registros já cadastrados?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
  begin
    if fileOpenDialog.Execute then
    begin
        xmlDoc.FileName:= fileOpenDialog.FileName;
        xmlDoc.Active:= true;

        for i := 0 to xmlDoc.DocumentElement.ChildNodes.Count - 1 do
        begin
           loadAtendimento:= TclassAtendimento.Create;
           with loadAtendimento, xmlDoc,xmlDoc.DocumentElement.ChildNodes[i] do
           begin
             horaInicial:=  strtotime(ChildNodes['HoraInicial'].Text);
             horaFinal:=  strtotime(ChildNodes['HoraFinal'].Text);
             dataReferencia:=  strtodate(ChildNodes['DataReferencia'].Text);
             quemInseriu:=  StrToBool(ChildNodes['QuemInseriu'].Text);
             lancadoHD:= StrToBool(ChildNodes['LancadoHD'].Text);
             descricao:=  ChildNodes['Descricao'].Text;
           end;
           //AdicionarHora(loadAtendimento);
           tempListaAtendimento.Adicionar(loadAtendimento);
           AdicionarHoraFaltante;
           AtualizarGrid;
           //loadAtendimento.Destroy;
        end;
    end;
  end;
end;

procedure TfrmAtendimento.sbtnAdicionarHoraClick(Sender: TObject);
var
  tempAtendimento: TclassAtendimento;
  dataRefRec: TDate;
  horaInicialRec, horaFinalRec: TTime;
  descricaoRec: String;
begin
  if ValidarHora(edtHoraInicial.Text) then
  begin
    if ValidarHora(edtHoraFinal.Text) then
    begin
      if StrToTime(edtHoraFinal.Text) > StrToTime(edtHoraInicial.Text) then
      begin
         tempAtendimento:= TclassAtendimento.Create;

         horaInicialRec:= StrToTime(edtHoraInicial.Text);
         horaFinalRec:= StrToTime(edtHoraFinal.Text);
         dataRefRec:= StrToDate(edtDataRef.Text);
         descricaoRec:= memoDescricao.Text;

         with tempAtendimento do
         begin
             dataReferencia:= dataRefRec;
             horaInicial:= horaInicialRec;
             horaFinal:= horaFinalRec;
             descricao:= descricaoRec;
             quemInseriu:= true;
             lancadoHD:= ckbLancadoHD.Checked;
         end;
          AdicionarHora(tempAtendimento);
      end
      else
      begin
        ShowMessage('A Hora Final não pode ser maior que a Hora Inicial');
        edtHoraInicial.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('Hora Final invalida');
      edtHoraFinal.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Hora Inicial inválida');
    edtHoraInicial.SetFocus;
  end;
end;

//Salvando Atendimentos no XML
procedure TfrmAtendimento.sbtnSalvarHorarioClick(Sender: TObject);
var
  ixmlAtendimento,Objeto: IXMLNode;
  listaAtendimento: TObjectList<TclassAtendimento>;
  tempAtendimento: TclassAtendimento;
  caminhoArquivo: String;
begin
  listaAtendimento:= tempListaAtendimento.RetornarLista;

  if listaAtendimento.Count > 0 then
  begin
    if fileSaveDialog.Execute then
    begin
      caminhoArquivo:= fileSaveDialog.FileName;
      if not ContainsText(caminhoArquivo, '.xml') then
        caminhoArquivo:= Concat(caminhoArquivo, '.xml');

      xmlDoc.Active:=true;
      xmlDoc.Version:= '1.0';
      xmlDoc.Encoding:= 'UTF-8';

      Objeto:= xmlDoc.AddChild('Objeto');

      for tempAtendimento in listaAtendimento do
      begin
         ixmlAtendimento:= Objeto.AddChild('Atendimento');
         ixmlAtendimento.Attributes['Oid']:= IntToStr(tempAtendimento.oid);

         ixmlAtendimento.AddChild('DataReferencia').Text := DateToStr(tempAtendimento.dataReferencia);
         ixmlAtendimento.AddChild('HoraInicial').Text := TimeToStr(tempAtendimento.horaInicial);
         ixmlAtendimento.AddChild('HoraFinal').Text := TimeToStr(tempAtendimento.horaFinal);
         ixmlAtendimento.AddChild('Descricao').Text := tempAtendimento.descricao;
         ixmlAtendimento.AddChild('LancadoHD').Text := BoolToStr(tempAtendimento.lancadoHD);
         ixmlAtendimento.AddChild('QuemInseriu').Text := BoolToStr(tempAtendimento.quemInseriu);

      end;
      xmlDoc.SaveToFile(caminhoArquivo);
      xmlDoc.Active:=false;
      ShowMessage('Cadastros salvos');
    end;
  end
  else
    ShowMessage('Não há cadastros para Salvar');
end;

procedure TfrmAtendimento.sbtnExcluirSelClick(Sender: TObject);
var
  oidAtendimentoSelecionado: Integer;
  atendimentoSelecionado: TclassAtendimento;
  listaAtendimento: TObjectList<TclassAtendimento>;
begin
  if linhaSelecionadaGrid <> 0 then
  begin
    oidAtendimentoSelecionado:= StrToInt(sgridHorarios.Cells[0, linhaSelecionadaGrid]);
    If Application.MessageBox('Deseja Excluir o Regitro selecionado ?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin
      listaAtendimento:= tempListaAtendimento.RetornarLista;

      for atendimentoSelecionado in listaAtendimento do
      begin
        if atendimentoSelecionado.oid = oidAtendimentoSelecionado then
        begin
          tempListaAtendimento.Remover(atendimentoSelecionado);
          AdicionarHoraFaltante;
        end;
      end;
      AtualizarGrid;
    end;
  end
  else
    ShowMessage('Selecione um Registro para Excluir!');
end;

// Marcaras de hora
procedure TfrmAtendimento.edtHoraFinalKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
  begin
    if key = #13 then
    begin
      sbtnAdicionarHora.Click;
    end
  end
  else
  begin
    if not(Key = #8) then
    begin
      if Length(edtHoraFinal.Text) = 2 then
      begin
        edtHoraFinal.Text:= Concat(edtHoraFinal.Text, ':');
        edtHoraFinal.SelStart:= Length(edtHoraFinal.Text);
      end;
    end;
  end;

end;

procedure TfrmAtendimento.edtHoraInicialKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
  begin
    if key = #13 then
    begin
      sbtnAdicionarHora.Click;
    end
  end
  else
  begin
    if not(Key = #8) then
    begin
      if Length(edtHoraInicial.Text) = 2 then
      begin
        edtHoraInicial.Text:= Concat(edtHoraInicial.Text, ':');
        edtHoraInicial.SelStart:= Length(edtHoraInicial.Text);
      end;
    end;
  end;
  if key = #13 then
  begin
     sbtnAdicionarHora.Click;
  end;

end;

//Pintar celulas
procedure TfrmAtendimento.sgridHorariosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  Const
// Aqui você define algumas cores em RGB, caso não queira utilizar as padrões do Delphi
  clPaleGreen = TColor($009BFF9B);
  clPaleRed =   TColor($009DABF9);
  clPaleYellow= TColor($00FFD700);
begin

  if Arow > 0 then
  begin
    if sgridHorarios.Cells[6,ARow] = 'NÃO' then
    begin
       if sgridHorarios.Cells[7,ARow] = 'NÃO'
          then sgridHorarios.Canvas.Brush.color := clYellow
       else
        if sgridHorarios.Cells[7,ARow] = 'SIM'
          then sgridHorarios.Canvas.Brush.color := clPaleRed;
    end
    else
    begin
        if sgridHorarios.Cells[6,ARow] = 'SIM'
          then sgridHorarios.Canvas.Brush.color := clPaleGreen;
    end;
  end;


  if (gdselected in state) then
  begin
    if ARow in [sgridHorarios.Selection.Left..sgridHorarios.Selection.Right] then
    begin
      sgridHorarios.Canvas.Font.Color := ClRed;;
    end;
  end;
  sgridHorarios.Canvas.Font.Color:=clblack;

  sgridHorarios.canvas.fillRect(Rect);
  sgridHorarios.canvas.TextOut(Rect.Left,Rect.Top,sgridHorarios.Cells[ACol,ARow]);
end;

procedure TfrmAtendimento.sgridHorariosMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
  var
    p: TPoint;
begin
  if ssRight in Shift then
  begin
    p := Mouse.CursorPos;
    PopupMenu1.Popup(p.X, p.Y);
  end;
end;

//Evento ao selecionar a celula
procedure TfrmAtendimento.sgridHorariosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  Const
    clPaleYellow= TColor($00FFD700);
begin
  sgridHorarios.Canvas.Font.Color:=clPaleYellow;
  linhaSelecionadaGrid:= ARow;
end;

//Parte da Aba Bloco de Notas
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
