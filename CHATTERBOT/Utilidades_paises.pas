unit Utilidades_paises;

interface
uses
  sysutils,crt;

function FormatearNumero(num: longint): string;
procedure Centrado(texto: string);

implementation


function FormatearNumero(num: longint): string;
var
  s,resultado: string;
  i, len: integer;
begin
  str(num, s);
  resultado := '';
  len := length(s);

  for i := 1 to len do
  begin
    resultado := resultado + s[i];
    if ((len - i) mod 3 = 0) and (i < len) then
      resultado := resultado + '.';
  end;

  FormatearNumero := resultado;
end;

procedure Centrado(texto: string);
begin
  gotoxy(40, whereY);
  writeln(texto);
end;

end.   


