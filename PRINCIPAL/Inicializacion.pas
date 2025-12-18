unit Inicializacion;
    
interface
uses
  SysUtils, Classes;

procedure arbol_en_memoria(var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_leg, arb_ayn, arb_ev:t_punt);

implementation

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