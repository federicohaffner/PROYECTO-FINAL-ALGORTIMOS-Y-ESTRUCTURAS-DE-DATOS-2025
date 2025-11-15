unit archivos;
{$mode ObjFPC}{$H+}
interface
const
     ruta_1='';
     ruta_2='';
     DISCAPACIDADES: ARRAY[1..5] OF STRING =('PROBLEMAS DEL HABLA Y LENGUAJE',
                                             'DIFICULTAD PARA ESCRIBIR',
                                             'DIFICULTADES DE APRENDIZAJE VISUAL',
                                             'MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO',
                                             'DESTREZAS SOCIALES INADECUADAS');
uses
  Classes, SysUtils, UNIT_ARBOL;
type
  t_dato_alumnos=record
    legajo:string[10];
    ayn:string;
    fecha_nac:string[10];
    estado:boolean;
    discapacidades:array [1..5] of boolean;
  end;
  t_archivo_alumnos=file of t_dato_alumnos;
  t_dato_evaluaciones=record
    legajo:string;
    fecha_ev:string[10];
    valoracion:array [1..5] of 0..4;
    observacion:string[100];
  end;
  t_archivo_evaluaciones=file of t_dato_evaluaciones;


function archivo_vacio (var archivo_1:t_archivo_alumnos): boolean;
function archivo_vacio (var archivo_2:t_archivo_alumnos): boolean;
procedure crear_abrir (var archivo_1:t_archivo_alumnos); 
procedure crear_abrir (var archivo_2:t_archivo_evaluaciones); 
procedure cerrar_archivo (var archivo_1:t_archivo_alumnos); 
procedure cerrar_archivo (var archivo_2:t_archivo_evaluaciones); 
procedure leer_archivo (var archivo_1:t_archivo_alumnos; pos:integer; x:t_dato_alumnos); 
procedure leer_archivo (var archivo_2:t_archivo_evaluaciones; pos:integer; x:t_dato_evaluaciones); 
procedure escribir_archivo (var archivo_1:t_archivo_evaluaciones; pos:integer; x:t_dato_evaluaciones); 
procedure escribir_archivo (var archivo_2:t_archivo_alumnos; pos:integer; x:t_dato_alumnos); 

implementation

function archivo_vacio (var archivo_1:t_archivo_alumnos): boolean;
begin
     archivo_vacio:=filesize(archivo_1)=0; 
end;

function archivo_vacio (var archivo_2:t_archivo_alumnos): boolean;
begin
     archivo_vacio:=filesize(archivo_2)=0; 
end;

procedure crear_abrir (var archivo_1:t_archivo_alumnos);
begin
     assign(archivo_1,ruta_1);
     {$I-}
     reset(archivo_1);
     {$I+}
     if IOResult <> 0 then
     begin
          rewrite(archivo_1);
     end;
end;

procedure crear_abrir (var archivo_2:t_archivo_evaluaciones);
begin
     assign(archivo_2,ruta_2);
     {$I-}
     reset(archivo_2);
     {$I+}
     if IOResult <> 0 then
     begin
          rewrite(archivo_2);
     end;
end;

procedure cerrar_archivo (var archivo_1:t_archivo_alumnos);
begin
     close(archivo_1);
end;

procedure cerrar_archivo (var archivo_2:t_archivo_evaluaciones);
begin
     close(archivo_2);
end;

procedure leer_archivo (var archivo_1:t_archivo_alumnos; pos:integer; var dato:t_dato_alumnos);
begin
     seek(archivo_1,pos);
     read(archivo_1,dato);
end;

procedure leer_archivo (var archivo_2:t_archivo_evaluaciones; pos:integer; var dato:t_dato_evaluaciones);
begin
     seek(archivo_2,pos);
     read(archivo_2,dato);
end;

procedure escribir_archivo (var archivo_1:t_archivo_alumnos; pos:integer; var dato:t_dato_alumnos);
begin
     seek(archivo_1,pos);
     write(archivo_1,dato);
end;

procedure escribir_archivo (var archivo_2:t_archivo_evaluaciones; pos:integer; var dato:t_dato_evaluaciones);
begin
     seek(archivo_2,pos);
     write(archivo_2,dato);
end;

procedure alta_evaluacion (var a:t_archivo_alumnos;var a1:t_archivo_evaluaciones);
var
     legajo:string;
     pos,i, op:byte;
     r:t_dato_alumnos;
     x:t_dato_evaluaciones;
     baja:boolean;
     val:0..4;
     fecha_ev:string[10];
     observacion:string[100];
begin
     cargar_legajo(legajo);
     buscar_legajo(a,legajo,baja,pos);
     if r.estado = true then
     begin
          seek(a,pos);
          read(a,r);
          x.legajo:= legajo;
          writeln('Ingrese la fecha actual: ');
          realdn(fecha_ev);
          if fecha_valida(fecha_ev) then
          begin
               for i := 1 to 5 do
               begin
                    if r.discapacidades[i]= true then
                    begin
                         writeln(DISCAPACIDADES[i]);
                         writeln('Ingrese la valoracion del dia: ');
                         readln (val);
                         x.valoracion[i] := val;
                    end;
               end;
          end;
          writeln('Ingrese la observacion del dia: ');
          readln(observacion);
          x.fecha_ev := fecha_ev;
          x.observacion:= observacion;
          seek(a1,filesize(a1));
          write(a1,x);
     end
     else
     begin
          if pos=-1 then
          begin
               writeln('El legajo ingresado no existe');
               writeln('¿Desea darlo de alta?     1-Si|0-No');
               readln(op);
               case op of
                    1: begin
                         alta_alumnos(a, legajo, arb_ayn, arb_leg);
                         alta_evaluacion(a, a1);
                       end;

                    0: menu_principal;
               end;
          end
          else
          begin
               writeln('El legajo ingresado esta dado de baja');
               writeln('¿Desea darlo de alta?     1-Si|0-No);
               readln(op);
               case op of
                    1:begin 
                         alta_logica(a,legajo);
                         alta_evaluacion(a,a1);
                      end;
                    0: menu_principal;
               end;
          end;
     end;
end;
end. 
