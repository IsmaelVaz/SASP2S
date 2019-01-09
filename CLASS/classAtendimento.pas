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
    FquemInseriu: boolean;
    FlancadoHD: boolean;
    FoidReal: integer;

    procedure SetdataReferencia(const Value: TDate);
    procedure SetDescricao(const Value: String);
    procedure SetHoraFinal(const Value: TTime);
    procedure SetHoraInicial(const Value: TTime);
    procedure SetOid(const Value: integer);
    procedure SetquemInseriu(const Value: boolean);
    procedure SetlancadoHD(const Value: boolean);
    procedure SetoidReal(const Value: integer);
  public
    property lancadoHD: boolean read FlancadoHD write SetlancadoHD;
    property dataReferencia: TDate read FdataReferencia write SetdataReferencia;
    property horaInicial: TTime read FHoraInicial write SetHoraInicial;
    property horaFinal: TTime read FHoraFinal write SetHoraFinal;
    property descricao: String read Fdescricao write SetDescricao;
    property oid: integer read FOid write SetOid;
    property quemInseriu: boolean read FquemInseriu write SetquemInseriu;
    property oidReal: integer read FoidReal write SetoidReal;
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

procedure TclassAtendimento.SetlancadoHD(const Value: boolean);
begin
  FlancadoHD := Value;
end;

procedure TclassAtendimento.SetOid(const Value: integer);
begin
  FOid := Value;
end;

procedure TclassAtendimento.SetoidReal(const Value: integer);
begin
  FoidReal := Value;
end;

procedure TclassAtendimento.SetquemInseriu(const Value: boolean);
begin
  FquemInseriu := Value;
end;

end.
