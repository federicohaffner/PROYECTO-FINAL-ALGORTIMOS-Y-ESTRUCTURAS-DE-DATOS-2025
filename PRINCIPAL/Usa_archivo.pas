unit usa_archivo;
{$mode ObjFPC}{$H+}

interface
uses
    SysUtils, archivos, unit_arbol, usa_arbol;

function archivo_vacio_1 (var archivo_1:t_archivo_alumnos): boolean;
function archivo_vacio_2 (var archivo_2:t_archivo_evaluaciones): boolean;
procedure crear_abrir_1 (var archivo_1:t_archivo_alumnos);
procedure crear_abrir_2 (var archivo_2:t_archivo_evaluaciones);
procedure cerrar_archivo_1 (var archivo_1:t_archivo_alumnos);
procedure cerrar_archivo_2 (var archivo_2:t_archivo_evaluaciones);
procedure leer_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
procedure leer_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
procedure escribir_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
procedure escribir_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
procedure arbol_en_memoria(var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_leg, arb_ayn, arb_ev:t_punt);

implementation

function archivo_vacio_1 (var archivo_1:t_archivo_alumnos): boolean;
begin
     archivo_vacio_1 := filesize(archivo_1) = 0;
end;

function archivo_vacio_2 (var archivo_2:t_archivo_evaluaciones): boolean;
begin
     archivo_vacio_2 := filesize(archivo_2) = 0;
end;

procedure crear_abrir_1 (var archivo_1:t_archivo_alumnos);
begin
     assign(archivo_1, ruta_1);
     {$I-} reset(archivo_1); {$I+}
     if IOResult <> 0 then rewrite(archivo_1);
end;

procedure crear_abrir_2 (var archivo_2:t_archivo_evaluaciones);
begin
     assign(archivo_2, ruta_2);
     {$I-} reset(archivo_2); {$I+}
     if IOResult <> 0 then rewrite(archivo_2);
end;

procedure cerrar_archivo_1 (var archivo_1:t_archivo_alumnos);
begin
     close(archivo_1);
end;

procedure cerrar_archivo_2 (var archivo_2:t_archivo_evaluaciones);
begin
     close(archivo_2);
end;

procedure leer_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
begin
     seek(archivo_1, pos);
     read(archivo_1, x);
end;

procedure leer_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
begin
     seek(archivo_2, pos);
     read(archivo_2, x);
end;

procedure escribir_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
begin
     seek(archivo_1, pos);
     write(archivo_1, x);
end;

procedure escribir_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
begin
     seek(archivo_2, pos);
     write(archivo_2, x);
end;


procedure arbol_en_memoria(var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_leg, arb_ayn, arb_ev:t_punt);
var
   x: t_dato_alumnos;
   y: t_dato_evaluaciones;
   dato_arb: t_dato_arbol;
   i, max: integer;
begin
   crear_arbol(arb_leg);
   crear_arbol(arb_ayn);
   crear_arbol(arb_ev);
   crear_abrir_1(a);
   max := filesize(a);
   if max > 0 then
   begin
        for i := 0 to max - 1 do
        begin
          leer_archivo_1(a, i, x);
          dato_arb.clave := x.legajo;
          dato_arb.pos_arch := i;
          agregar(arb_leg, dato_arb);
          dato_arb.clave := x.ayn;
          dato_arb.pos_arch := i;
          agregar(arb_ayn, dato_arb);
        end;
   end;

   crear_abrir_2(e);
   max := filesize(e);
   if max > 0 then
   begin
        for i := 0 to max - 1 do
        begin
          leer_archivo_2(e, i, y);
          dato_arb.clave := y.fecha_ev + ' ' + y.legajo;
          dato_arb.pos_arch := i;
          agregar_arbol_eval(arb_ev, dato_arb);
        end;
   end;
end;

end.     