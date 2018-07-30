unit classListaAtendimento;

interface

uses
  Classes, classAtendimento, Dialogs, SysUtils, Generics.Collections;

type
  TclassListaAtendimento = class

  private
    FListaAtendimento: TObjectList<TclassAtendimento>;

  public
    constructor Create;
    procedure Adicionar(atendimento: TclassAtendimento);
    procedure Remover(index:Integer);
    function RetornarLista:TObjectList<TclassAtendimento>;
  end;

implementation

constructor TclassListaAtendimento.Create;
begin
  inherited Create;
  FListaAtendimento:= TObjectList<TclassAtendimento>.Create;
end;

function TclassListaAtendimento.RetornarLista;
begin
  Result:= FListaAtendimento;
end;

procedure TclassListaAtendimento.Adicionar(atendimento: TclassAtendimento);
var
  ultimoOid:integer;
begin

  atendimento.quemInseriu:= true;
  if FListaAtendimento.Count = 0 then
  begin
    atendimento.oid:= 1;
    FListaAtendimento.Add(atendimento);
  end

  else
  begin
    ultimoOid:= FListaAtendimento.Last.oid + 1;
    atendimento.oid:=ultimoOid;
    FListaAtendimento.Add(atendimento);
  end;

end;

procedure TclassListaAtendimento.Remover(index:Integer);
begin
    if index < FListaAtendimento.count then
      FListaAtendimento.Delete(index)
    else
      ShowMessage('Item não Encontrado');
end;
end.
