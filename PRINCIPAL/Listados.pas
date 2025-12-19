unit Listados;
{$mode ObjFPC}{$H+}
interface

uses
    crt, SysUtils, Classes, Unit_arbol, Archivos, Validaciones, Usa_arbol, Interfaz_aux, Evaluaciones, Alumnos, Usa_archivo;

procedure listado_alumnos(arb_ayn:t_punt; var a: t_archivo_alumnos);
procedure listado_ev(var a: t_archivo_alumnos; arb_ayn,arb_leg,arb_ev: t_punt; var e: t_archivo_evaluaciones);
procedure listado_dificultad (arb_ayn:t_punt; dif:byte; var arch:t_archivo_alumnos);
procedure inorden_leg(raiz: t_punt; leg_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
procedure inorden_dif(raiz: t_punt; dif: byte; var arch: t_archivo_alumnos; var linea: integer);

implementation

procedure listado_alumnos(arb_ayn: t_punt; var a: t_archivo_alumnos);
var
    linea: integer;
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        Encabezado_Alumnos;
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
        TextoCentrado(11, 'SIN DATOS', LightRed);
        TextoCentrado(12, 'No hay alumnos en el sistema', LightGray);
        readkey;
    end;
end;

procedure listado_ev(var a: t_archivo_alumnos; arb_ayn, arb_leg, arb_ev: t_punt; var e: t_archivo_evaluaciones);
var
   linea: integer;
   legajo: string;
begin
   clrscr;
   if arb_ev <> nil then
   begin
       legajo := ingresar_legajo;
       if legajo <> '0' then
       begin
           if Resolver_Estado_Alumno(legajo, a, arb_leg, arb_ayn) then
           begin
               Encabezado_Evaluaciones(legajo);
               linea := 8;
               inorden_leg(arb_ev, legajo, linea, e);
               textcolor(LightGreen);
               gotoxy(6, 22);
               writeln('--------------------------------------------------------------------');
               textcolor(White);
               gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
               readkey;
           end
           else
           begin
               clrscr;
               DibujarMarco(20, 10, 60, 14, LightGreen);
               TextoCentrado(11, 'OPERACION CANCELADA', LightRed);
               TextoCentrado(12, 'No se puede mostrar el listado.', LightGray);
               readkey;
           end;
       end;
   end
   else
   begin
       DibujarMarco(20, 10, 60, 14, LightGreen);
       TextoCentrado(11, 'SIN DATOS', LightRed);
       TextoCentrado(12, 'No hay evaluaciones cargadas', LightGray);
       readkey;
   end;
end;

procedure listado_dificultad(arb_ayn: t_punt; dif: byte; var arch: t_archivo_alumnos);
var
    linea: integer;
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        Encabezado_Dificultad(dif);
        linea := 8;
        inorden_dif(arb_ayn, dif, arch, linea);
        textcolor(LightGreen);
        gotoxy(6, 22);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightGreen);
        TextoCentrado(11, 'SIN DATOS', LightRed);
        TextoCentrado(12, 'No hay evaluaciones para la dificultad', LightGray);
        readkey;
    end;
end;

procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
var
   reg: t_dato_alumnos;
begin
   if raiz <> nil then
   begin
      inorden_alumnos_activos(raiz^.sai, a, linea);
      leer_archivo_1(a, raiz^.info.pos_arch, reg);
      if reg.estado = true then
      begin
          Render_Alumno(reg, linea, 1, 0);
      end;
      inorden_alumnos_activos(raiz^.sad, a, linea);
   end;
end;

procedure inorden_dif(raiz: t_punt; dif: byte; var arch: t_archivo_alumnos; var linea: integer);
var
  r: t_dato_alumnos;
begin
  if raiz <> nil then
  begin
    inorden_dif(raiz^.sai, dif, arch, linea);
    leer_archivo_1(arch, raiz^.info.pos_arch, r);
    if (r.estado = true) and (r.dificultades[dif] = true) then
    begin
        Render_Alumno(r, linea, 3, dif);
    end;
    inorden_dif(raiz^.sad, dif, arch, linea);
  end;
end;

procedure inorden_leg(raiz: t_punt; leg_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
var
  leg_nodo: string;
  reg: t_dato_evaluaciones;
begin
  if raiz <> nil then
  begin
    inorden_leg(raiz^.sai, leg_buscado, linea, e);
    if Length(raiz^.info.clave) > 11 then
    begin
         leg_nodo := Copy(raiz^.info.clave, 12, Length(raiz^.info.clave)-11);
         if leg_nodo = leg_buscado then
         begin
            leer_archivo_2(e, raiz^.info.pos_arch, reg);
            Render_Evaluacion(reg, linea, leg_buscado);
         end;
    end;
    inorden_leg(raiz^.sad, leg_buscado, linea, e);
  end;
end;
end. 