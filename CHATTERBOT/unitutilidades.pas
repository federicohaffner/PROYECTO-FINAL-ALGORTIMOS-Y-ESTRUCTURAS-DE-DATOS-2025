unit UnitUtilidades;

interface

function FormatearNumero(num: longint): string;
function CompletarConEspacios(texto: string; longitud: integer): string;
function CortarTexto(texto: string; longitud: integer): string;
function ObtenerFechaActual: string;
function ObtenerHoraActual: string;

implementation

uses
  sysutils;

function FormatearNumero(num: longint): string;
var
  s: string;
  i, len: integer;
  resultado: string;
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

function CompletarConEspacios(texto: string; longitud: integer): string;
var
  resultado: string;
  i: integer;
begin
  resultado := texto;
  for i := length(texto) + 1 to longitud do
    resultado := resultado + ' ';
  CompletarConEspacios := resultado;
end;

function CortarTexto(texto: string; longitud: integer): string;
begin
  if length(texto) <= longitud then
    CortarTexto := texto
  else
    CortarTexto := copy(texto, 1, longitud);
end;

function ObtenerFechaActual: string;
begin
  ObtenerFechaActual := DateToStr(Date);
end;

function ObtenerHoraActual: string;
begin
  ObtenerHoraActual := TimeToStr(Time);
end;

end.
