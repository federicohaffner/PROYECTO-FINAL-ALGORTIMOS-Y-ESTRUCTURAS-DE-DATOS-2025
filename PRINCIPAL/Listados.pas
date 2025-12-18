unit Listados;
{$mode ObjFPC}{$H+}
interface

uses
    crt, SysUtils, Classes, Unit_arbol, Archivos, Validaciones, Usa_arbol, Interfaz_aux;

procedure listado_alumnos(arb_ayn:t_punt; var a: t_archivo_alumnos);
procedure listado_ev (arb_ev:t_punt; legajo:string; var e: t_archivo_evaluaciones);
procedure listado_discapacidad (arb_ayn:t_punt; disc:byte; var arch:t_archivo_alumnos);
procedure inorden_leg(raiz: t_punt; legajo_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
procedure inorden_disc(raiz: t_punt; disc: byte; var arch: t_archivo_alumnos; var linea: integer);

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

procedure inorden_leg(raiz: t_punt; legajo_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
var
  legajo_en_nodo: string;
  reg: t_dato_evaluaciones;
  i: integer;
begin
  if raiz <> nil then
  begin
    inorden_leg(raiz^.sai, legajo_buscado, linea, e);
    if Length(raiz^.info.clave) > 11 then
    begin
         legajo_en_nodo := Copy(raiz^.info.clave, 12, Length(raiz^.info.clave)-11);
         if legajo_en_nodo = legajo_buscado then
         begin
            seek(e, raiz^.info.pos_arch);
            read(e, reg);
            textcolor(White);
            gotoxy(10, linea); write(reg.fecha_ev);
            gotoxy(30, linea); write(Copy(reg.observacion, 1, 25));
            if Length(reg.observacion) > 25 then write('...');
            gotoxy(60, linea);
            for i := 1 to 5 do
            begin
                 if reg.valoracion[i] > 0 then textcolor(White) else textcolor(DarkGray);
                 write(reg.valoracion[i]);
                 textcolor(LightGray);
                 if i < 5 then write(',');
            end;
            linea := linea + 1;
            if linea > 21 then linea := 21;
         end;
    end;
    inorden_leg(raiz^.sad, legajo_buscado, linea, e);
  end;
end;

procedure inorden_disc(raiz: t_punt; disc: byte; var arch: t_archivo_alumnos; var linea: integer);
var
  r: t_dato_alumnos;
begin
  if raiz <> nil then
  begin
    inorden_disc(raiz^.sai, disc, arch, linea);
    seek(arch, raiz^.info.pos_arch);
    read(arch, r);
    if (r.estado = true) and (r.discapacidades[disc] = true) then
    begin
       gotoxy(10, linea); Write(r.ayn);
       gotoxy(50, linea); Write(r.legajo);
       linea:=linea+1
    end;
    inorden_disc(raiz^.sad, disc, arch, linea);
  end;
end;

procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
var
   reg: t_dato_alumnos;
begin
   if raiz <> nil then
   begin
      inorden_alumnos_activos(raiz^.sai, a, linea);
      seek(a, raiz^.info.pos_arch);
      read(a, reg);
      if reg.estado = true then
      begin
           linea := linea + 1;
           if linea > 22 then
           begin
               gotoxy(10, 24); write('Presione una tecla para continuar...');
               readkey;
               clrscr;
               linea := 4;
           end;
           gotoxy(10, linea); write(reg.ayn);
           gotoxy(50, linea); write(reg.legajo);
           linea := linea + 1;
      end;
      inorden_alumnos_activos(raiz^.sad, a, linea);
   end;
end;


end.