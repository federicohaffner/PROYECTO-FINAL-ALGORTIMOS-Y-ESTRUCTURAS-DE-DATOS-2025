unit interfaz_aux;
{$mode ObjFPC}{$H+}
interface
uses
    Crt, Archivos;

procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
procedure TextoCentrado(y: integer; texto: string; color: byte);
procedure Encabezado_Alumnos;
procedure Encabezado_Evaluaciones(legajo: string);
procedure Encabezado_Dificultad(dif: byte);
procedure Paginacion(var linea: integer; tipo_listado: integer; legajo: string; dif: byte);
procedure Render_Alumno(r: t_dato_alumnos; var l: integer; tipo: integer; dif: byte);
procedure Render_Evaluacion(r: t_dato_evaluaciones; var l: integer; legajo: string);

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

procedure Encabezado_Alumnos;
begin
    DibujarMarco(5, 2, 75, 24, LightGreen);
    TextoCentrado(3, 'LISTADO DE ALUMNOS ACTIVOS', White);
    TextoCentrado(4, 'Ordenado alfabeticamente', LightGreen);
    textcolor(LightGreen);
    gotoxy(6, 5);  writeln('--------------------------------------------------------------------');
    gotoxy(10, 6); write('APELLIDO Y NOMBRE');
    gotoxy(50, 6); write('LEGAJO');
    gotoxy(6, 7);  writeln('--------------------------------------------------------------------');
end;

procedure Encabezado_Evaluaciones(legajo: string);
begin
    DibujarMarco(5, 2, 75, 24, LightGreen);
    TextoCentrado(3, 'LISTADO DE EVALUACIONES', White);
    textcolor(LightGreen);
    gotoxy(28, 4); write('Legajo: ', legajo);
    gotoxy(6, 5);  writeln('--------------------------------------------------------------------');
    gotoxy(10, 6); write('FECHA');
    gotoxy(30, 6); write('OBSERVACIONES');
    gotoxy(60, 6); write('VALORACION');
    gotoxy(6, 7);  writeln('--------------------------------------------------------------------');
end;

procedure Encabezado_Dificultad(dif: byte);
begin
    DibujarMarco(5, 2, 75, 24, LightGreen);
    TextoCentrado(3, 'LISTADO POR DIFICULTAD', White);
    textcolor(LightGreen);
    gotoxy(20, 4); write('Dificultad: ', DIFICULTADES[dif]);
    gotoxy(6, 5);  writeln('--------------------------------------------------------------------');
    gotoxy(10, 6); write('APELLIDO Y NOMBRE');
    gotoxy(50, 6); write('LEGAJO');
    gotoxy(6, 7);  writeln('--------------------------------------------------------------------');
end;

procedure Paginacion(var linea: integer; tipo_listado: integer; legajo: string; dif: byte);
begin
    if linea > 22 then
    begin
        textcolor(White);
        gotoxy(20, 24); write('Presione una tecla para continuar...');
        readkey;
        clrscr;
        case tipo_listado of
            1: Encabezado_Alumnos;
            2: Encabezado_Evaluaciones(legajo);
            3: Encabezado_Dificultad(dif);
        end;
        linea := 8;
    end;
end;

procedure Render_Alumno(r: t_dato_alumnos; var l: integer; tipo: integer; dif: byte);
begin
    Paginacion(l, tipo, '', dif);
    textcolor(LightGray);
    gotoxy(10, l); write(r.ayn);
    gotoxy(50, l); write(r.legajo);
    l := l + 1;
end;

procedure Render_Evaluacion(r: t_dato_evaluaciones; var l: integer; legajo: string);
var i: integer;
begin
    Paginacion(l, 2, legajo, 0);
    textcolor(White);
    gotoxy(10, l); write(r.fecha_ev);
    gotoxy(30, l); write(Copy(r.observacion, 1, 25));
    if Length(r.observacion) > 25 then write('...');
    gotoxy(60, l);
    for i := 1 to 5 do
    begin
         if r.valoracion[i] > 0 then textcolor(White) else textcolor(DarkGray);
         write(r.valoracion[i]);
         textcolor(LightGray);
         if i < 5 then write(',');
    end;
    l := l + 1;
end;
end.    