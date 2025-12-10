unit Listados;
{$mode ObjFPC}{$H+}
interface

uses
    crt, SysUtils, Classes, unit_arbol, archivos, validaciones, usa_arbol, interfaz_aux;

procedure listado_alumnos(arb_ayn:t_punt; var a: t_archivo_alumnos);
procedure listado_ev (arb_ev:t_punt; legajo:string; var e: t_archivo_evaluaciones);
procedure listado_discapacidad (arb_ayn:t_punt; disc:byte; var arch:t_archivo_alumnos  );

implementation

procedure listado_alumnos(arb_ayn:t_punt; var a: t_archivo_alumnos);
var
    linea: integer;
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightGreen);
        TextoCentrado(3, 'LISTADO DE ALUMNOS ACTIVOS', White);
        TextoCentrado(4, 'Ordenado alfabeticamente', LightGreen);
        textcolor(LightGreen);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');
        gotoxy(10, 6); write('APELLIDO Y NOMBRE');
        gotoxy(50, 6); write('LEGAJO');
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGray);
        linea := 8;
        inorden_alumnos_activos(arb_ayn, a, linea);
        textcolor(LightGreen);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightGreen);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay alumnos cargados en el sistema', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end;
end;

procedure listado_ev (arb_ev:t_punt; legajo:string; var e: t_archivo_evaluaciones);
var
    linea: integer;
begin
    clrscr;
    if arb_ev <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightGreen);
        TextoCentrado(3, 'LISTADO DE EVALUACIONES', White);
        textcolor(LightGreen);
        gotoxy(28, 4); write('Legajo del alumno: ', legajo);
        textcolor(LightGreen);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGreen);
        gotoxy(10, 6); write('FECHA');
        gotoxy(30, 6); write('OBSERVACIONES');
        gotoxy(60, 6); write('VALORACION');
        textcolor(LightGreen);
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        linea := 8;
        inorden_leg(arb_ev, legajo, linea, e);
        textcolor(LightGreen);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightGreen);
        TextoCentrado(11, 'SIN DATOS', LightRed);
        TextoCentrado(12, 'No hay evaluaciones cargadas', LightGray);
        readkey;
    end;
end;


procedure listado_discapacidad (arb_ayn:t_punt; disc:byte; var arch:t_archivo_alumnos);
var
    linea:integer;
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightGreen);
        TextoCentrado(3, 'LISTADO POR DISCAPACIDAD', White);
        textcolor(LightGreen);
        gotoxy(25, 4); write('Discapacidad: ', DISCAPACIDADES[disc]);
        textcolor(LightGreen);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGreen);
        gotoxy(10, 6); write('APELLIDO Y NOMBRE');
        gotoxy(50, 6); write('LEGAJO');
        textcolor(LightGreen);
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGreen);
        gotoxy(10, 8);
        linea:=8;
        inorden_disc(arb_ayn, disc, arch, linea);
        textcolor(LightGreen);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightGreen);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay alumnos cargados en el sistema', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end;
end;

end.