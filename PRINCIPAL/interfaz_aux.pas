unit interfaz;
{$mode ObjFPC}{$H+}
interface
procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
procedure TextoCentrado(y: integer; texto: string; color: byte);

implementation

procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
var
  i: integer;
begin
  textcolor(color);
  gotoxy(x1, y1); write(#201); { ╔ }
  gotoxy(x2, y1); write(#187); { ╗ }
  gotoxy(x1, y2); write(#200); { ╚ }
  gotoxy(x2, y2); write(#188); { ╝ }
  for i := x1 + 1 to x2 - 1 do
  begin
    gotoxy(i, y1); write(#205); { ═ }
    gotoxy(i, y2); write(#205); { ═ }
  end;
  for i := y1 + 1 to y2 - 1 do
  begin
    gotoxy(x1, i); write(#186); { ║ }
    gotoxy(x2, i); write(#186); { ║ }
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