unit interfaz_aux;
{$mode ObjFPC}{$H+}
interface
uses
    crt;
procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
procedure TextoCentrado(y: integer; texto: string; color: byte);

implementation

procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
var
  i: integer;
begin
  textcolor(color);
  for i := x1 + 1 to x2 - 1 do
  begin
    gotoxy(i, y1); write('-');
    gotoxy(i, y2); write('-');
  end;
  for i := y1 + 1 to y2 - 1 do
  begin
    gotoxy(x1, i); write('|');
    gotoxy(x2, i); write('|');
  end;
end;
procedure TextoCentrado(y: integer; texto: string; color: byte);
var
  x: integer;
begin
  x := (80 - length(texto)) div 2;
  textcolor(color);
  gotoxy(x, y);
  write(texto);
end;
end.   