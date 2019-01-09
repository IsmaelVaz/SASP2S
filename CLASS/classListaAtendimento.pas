unit classListaAtendimento;

interface

uses
  Classes, classAtendimento, Dialogs, SysUtils, Generics.Collections, Generics.Defaults;

type
  TclassListaAtendimento = class

  private
    FListaAtendimento: TObjectList<TclassAtendimento>;

  public
    constructor Create;
    procedure Adicionar(atendimento: TclassAtendimento);
    procedure Remover(atendimento: TclassAtendimento);
    procedure Ordenar();
    procedure LancarID();
    function RetornarLista:TObjectList<TclassAtendimento>;
    function Contar:Integer;
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

procedure TclassListaAtendimento.LancarID;
var
  tempAtendimento: TclassAtendimento;
  idAux:integer;
begin
  idAux:= 1;
  for tempAtendimento in FListaAtendimento do
  begin
     tempAtendimento.oid:= idAux;
     idAux:= idAux+1;
  end;
end;
procedure TclassListaAtendimento.Adicionar(atendimento: TclassAtendimento);
var
  ultimoOid:integer;
begin
  // Ordenar;
  //atendimento.quemInseriu:= true;
  {if FListaAtendimento.Count = 0 then
  begin
    atendimento.oid:= 1;
    FListaAtendimento.Add(atendimento);
  end }

 // else
 // begin
    //ultimoOid:= FListaAtendimento.Last.oid + 1;
   // atendimento.oid:=ultimoOid;
    FListaAtendimento.Add(atendimento);
 // end;

   Ordenar;
   LancarID;
end;
function TclassListaAtendimento.Contar:Integer;
begin
  Result:= FListaAtendimento.Count;
end;

procedure TclassListaAtendimento.Remover(atendimento: TclassAtendimento);
begin
      FListaAtendimento.Remove(atendimento);
end;

procedure TclassListaAtendimento.Ordenar();
var
  Lista: TObjectList<TclassAtendimento>;
  comparison: TComparison<TclassAtendimento>;
  delegateComparer: TDelegatedComparer<TclassAtendimento>;
begin
  Lista:= FListaAtendimento;
  // método anonimo para ordenação crescente por ID
  comparison := function (const P1, P2: TclassAtendimento): Integer
    begin
      Result := CompareText(timetostr(P1.horaInicial), timetostr(P2.horaInicial));
    end;

  // método anonimo para ordenação decrescente por ID
  { comparison := function (const P1, P2: TPessoa): Integer
    begin
      Result := - CompareText(P1.Id, P2.Id);
    end; }

  // classe que implementa TComparer<T> e facilita o uso.
  // passe o método de comparação para o delegate!
  delegateComparer := TDelegatedComparer<TclassAtendimento>.Create(comparison);
  try
    // Usando método Sort da nossa lista passando nosso "ordenador"
    Lista.Sort(delegateComparer);
  finally
    delegateComparer.Free;
  end;
end;
end.
