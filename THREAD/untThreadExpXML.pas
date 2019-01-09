unit untThreadExpXML;

interface

uses
  Classes, SysUtils, Variants, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StrUtils, Grids, classAtendimento,
  classListaAtendimento, Generics.Collections, xmldom, XMLIntf, msxmldom, XMLDoc,
  Menus;
type
  TuntThreadExpXML = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    function ExportarXml(listaAtendimento: TObjectList<TclassAtendimento>; caminhoArquivo: String): boolean;
  public
    listaAtendimento: TObjectList<TclassAtendimento>;
    caminhoArquivo: String
  end;

implementation

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure untThreadExpXML.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ untThreadExpXML }
function  TuntThreadExpXML.ExportarXml(listaAtendimento: TObjectList<TclassAtendimento>; caminhoArquivo: String):boolean;
var
  ixmlAtendimento,Objeto: IXMLNode;
  tempAtendimento: TclassAtendimento;
  xmlDoc: IXMLDocument;
  qtdRegistro: Integer;
begin
   qtdRegistro:= listaAtendimento.Count;
  xmlDoc:= TXMLDocument.Create(nil);

  xmlDoc.Active:=true;
  xmlDoc.Version:= '1.0';
  xmlDoc.Encoding:= 'UTF-8';
  Objeto:= nil;
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
  ShowMessage('Cadastros salvos'+#13+caminhoArquivo+#13+'Qtd: '+inttostr(qtdRegistro));

end;
procedure TuntThreadExpXML.Execute;
begin
  { Place thread code here }
  ExportarXml(listaAtendimento, caminhoArquivo);
end;

end.
