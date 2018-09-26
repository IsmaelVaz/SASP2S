unit classAtendimento;

interface

type
  TclassAtendimento = class
  private
    FhoraFinal: TTime;
    FhoraInicial: TTime;
    Fdescricao: String;
    Foid: integer;
    FdataReferencia: TDate;
    procedure SetdataReferencia(const Value: TDate);
    procedure SetDescricao(const Value: String);
    procedure SetHoraFinal(const Value: TTime);
    procedure SetHoraInicial(const Value: TTime);
    procedure SetOid(const Value: integer);
  private
    FquemInseriu: boolean;
    procedure SetquemInseriu(const Value: boolean);

  public
    property dataReferencia: TDate read FdataReferencia write SetdataReferencia;
    property horaInicial: TTime read FHoraInicial write SetHoraInicial;
    property horaFinal: TTime read FHoraFinal write SetHoraFinal;
    property descricao: String read Fdescricao write SetDescricao;
    property oid: integer read FOid write SetOid;
    property quemInseriu: boolean read FquemInseriu write SetquemInseriu;
  private
  published
  published
  protected

end;

implementation

{ TclassAtendimento }


{ TclassAtendimento }

procedure TclassAtendimento.SetdataReferencia(const Value: TDate);
begin
  FdataReferencia := Value;
end;

procedure TclassAtendimento.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TclassAtendimento.SetHoraFinal(const Value: TTime);
begin
  FHoraFinal := Value;
end;

procedure TclassAtendimento.SetHoraInicial(const Value: TTime);
begin
  FHoraInicial := Value;
end;

procedure TclassAtendimento.SetOid(const Value: integer);
begin
  FOid := Value;
end;

procedure TclassAtendimento.SetquemInseriu(const Value: boolean);
begin
  FquemInseriu := Value;
end;

end.
