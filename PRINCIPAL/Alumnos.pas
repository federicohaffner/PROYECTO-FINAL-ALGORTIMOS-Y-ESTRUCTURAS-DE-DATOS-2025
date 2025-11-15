unit alumnos;
{$mode ObjFPC}{$H+}
interface
const
uses
  Classes, SysUtils, archivos, arboles;

procedure cargar_legajo(var r:t_dato_alumnos); 
procedure cargar_ayn(var r:t_dato_alumnos); 
procedure fecha_nac (var r:t_dato_alumnos); 
procedure tiene_disc (var r:t_dato_alumnos); 
procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer); 
procedure alta_alumnos (var a: t_archivo_alumnos; legajo: string; var arb_leg: t_punt; var arb_ayn: t_punt); 
procedure mostrar_registro_al (x:t_dato_alumnos); 
procedure cargar_registro (var r:t_dato_alumnos, legajo: string); 
procedure buscar_legajo(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string); 
procedure consulta_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string); 
procedure modificar_alumno(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);

implementation

procedure cargar_legajo(var r:t_dato_alumnos);
var
   legajo:string[10];
begin
     write('Por favor ingrese el legajo: ');
     readln(legajo);
     while not(legajo_valido(legajo)) do
     begin
       writeln('Escriba un legajo valido');
       readln(legajo);
     end;
     r.legajo:=legajo;
end;

procedure cargar_ayn(var r:t_dato_alumnos);
var
   ayn:string;
begin
     write('Por favor ingrese el apellido y nombre: ');
     readln(ayn);
     while not(escadena(ayn)) do
     begin
          writeln('Escriba un apellido y nombre valido: ');
          readln(ayn);
     end;
     r.ayn:=ayn;
end;

procedure fecha_nac (var r:t_dato_alumnos);
var
   f:string[10];
begin
     writeln('Por favor ingrese la fecha de nacimiento: (dd/mm/aaaa) ');
     readln(f);
     while not(fecha_valida(f)) do
     begin
       writeln('Escriba una fecha valida: ');
       readln(f);
     end;
     r.fecha_nac:=f;
end;

procedure tiene_disc (var r:t_dato_alumnos);
var
   op:char;
begin
       writeln('Marque las discapacidades que presenta');
       writeln('"V" (verdadero)');
       writeln('"F" (falso)');
     for i:= 1 to 5 do
     begin
       write(discapacidad[i], '; ' );
       readln(op);
       while (upcase(op)<>'V') and (upcase(op)<>'F') do
       begin
         writeln('Por favor, ingrese solamente "V" o "F": ');
         readln(op);
       end;
       if upcase(op) = 'V' then
          r.discapacidades[i]:=true
       else
           r.discapacidades[i]:=false;
     end;
end;

procedure mostrar_registro_al (x:t_dato_alumnos);
var
     i:byte;
begin
     writeln('Legajo: ', x.legajo);
     writeln('Apellido y Nombre: ', x.ayn);
     writeln('Fecha Nacimiento: ', x.fecha_nac);
     write('Estado: ');
     if x.estado = true then
          writeln('Activo')
     else
          writeln('De Baja');
          writeln('Dificultades que presenta:');
     for i:= 1 to 5 do
     begin
          if x.discapacidades[i] = true then
          begin
               writeln(' - ', DISCAPACIDADES[i]);
          end;
     end;
end;

procedure cargar_registro (var r:t_dato_alumnos, legajo: string);
begin
     r.legajo:=legajo;
     cargar_ayn(r);
     fecha_nac(r);
     tiene_disc(r);
     r.estado:=true;
end;

procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer; var r: t_dato_alumnos);
begin
     cargar_registro(r, legajo);
     seek(a,pos);
     write(a,r);
end;

procedure alta_alumnos (var a: t_archivo_alumnos; legajo: string; var arb_leg:t_punt, arb_ayn: t_punt);
var
     pos:integer;
     dato_ayn,x,dato_leg:t_dato_arbol;
     r:t_dato_alumnos;
     encontrado: boolean;
     op:char;
begin
     encontrado := false;
     pos:=0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado=false then
     begin
          pos:=filesize(a);
          agregar_archivo_alumno(a, legajo, pos, r);

          dato_leg.clave := r.legajo;
          dato_leg.pos_arch := pos;
          carga_arbol_alum(arb_leg, dato_leg);

          dato_ayn.clave := r.ayn;
          dato_ayn.pos_arch := pos;
          carga_arbol_alum(arb_ayn ,dato_ayn);
     end
     else
     begin
          pos:=x.pos_arch
          leer_archivo(a, pos, r);
          mostrar_registro(r);
          if y.estado = true then
               writeln('El alumno ya se encuentra registrado y dado de alta')
          else
          begin
               writeln('El alumno se encuentra registrado pero esta dado de baja');
               writeln('¿Desea darlo de alta? S/N');
               readln(op);
               if upcase(op)='S'  then
               begin
                    clrscr;
                    y.estado:=true
                    escribir_archivo(a,pos,y);
                    writeln('Alumno agregado con exito');
               end;
          end;       
     end;
end;

procedure buscar_legajo(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
y:t_dato_alumnos;
x:t_dato_arbol;
encontrado:boolean;
pos:integer;
op:char;
begin
     encontrado := false;
     pos=:0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado=true then
     begin
          pos:=x.pos_arch
          leer_archivo(a, pos,y);
          mostrar_registro(y);
     end
     else
     begin
          writeln('Alumno no encontrado');
          writeln('¿Desea agregarlo? S/N ');
          readln(op);
          if upcase(op)='S'  then
          begin
               clrscr;
               alta_alumnos(a, legajo, arb_leg, arb_ayn);
               writeln('Alumno agregado con exito');
          end;
     end;
end;

procedure baja_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y:t_dato_alumnos;
     x:t_dato_arbol
     encontrado:boolean;
     pos:integer;
     op:char;
begin
     encontrado := false;
     pos=:0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado=true then
     begin
          pos:=x.pos_arch
          leer_archivo(a, pos, y);
          if y.estado = true then
          begin
               y.estado:=false;
               escribir_archivo(a,pos,y);
               writeln('Alumno dado de baja con exito');
          end
          else
               writeln('El alumno ya se encuentra dado de baja');
     end
     else
           writeln('El alumno no se encuentra en el sistema');
end;

procedure consulta_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y:t_dato_alumnos;
     x:t_dato_arbol
     encontrado:boolean;
     pos:integer;
     op:char;
begin
     encontrado := false;
     pos=:0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado=true then
     begin
          pos:=x.pos_arch
          leer_archivo(a, pos, y);
          mostrar_registro(y);
     end
     else
     begin
          writeln('Alumno no encontrado');
          writeln('¿Desea agregarlo? S/N ');
          readln(op);
          if upcase(op)='S'  then
          begin
               clrscr;
               alta_alumnos(a, legajo, arb_leg, arb_ayn);
               writeln('Alumno agregado con exito');
          end;
     end;     
end;

procedure modificar_alumno(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y:t_dato_alumnos;
     x:t_dato_arbol
     encontrado:boolean;
     pos:integer;
     op:char;
begin
     encontrado := false;
     pos=:0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado=true then
     begin
          pos:=x.pos_arch
          repeat
               clrscr;
               leer_archivo(a, pos, y);
               mostrar_registro(y);
               gotoxy(15, 6); {hay que cambiarlo para que se vea la informacion actual y al costado las preguntas}
               writeln(¿Que desea modificar?);
               gotoxy(15, 8); 
               writeln('1- Apellido y Nombre:');
               gotoxy(15, 10); 
               writeln('2- Fecha de Nacimiento: ');
               gotoxy(15, 12); 
               writeln('3- Dificultades: ');
               writeln('0- Salir');
               read(op);
               case op of
                    1:begin
                         clrscr;
                         writeln('Modificar apellido y nombre: ');
                         readln(ayn);
                         while not(escadena(ayn)) do
                         begin
                              writeln('ingrese un nombre valido');
                              readln(ayn);
                         end;
                         y.ayn:=ayn;
                         suprime(arb_ayn, x);
                         x.clave:=ayn;
                         carga_arbol_alum(arb_ayn, x);
                    end;
                    2:begin
                         clrscr;
                         writeln('Modificar fecha de nacimiento: ');
                         readln(fecha);
                         while not(fecha_valida(fecha)) do
                         begin
                              writeln('ingrese una fecha valida');
                              readln(fecha);
                         end;
                         y.fecha:=fecha;
                    end;
                    3:begin
                         clrscr;
                         writeln('Modificar discapacidades:');
                         for i := 1 to 5 do
                         begin
                              write(DISCAPACIDADES[i], ' (V/F): ');
                              readln(disc);
                              if upcase(disc)='V' then 
                                   y.discapacidades[i] :=true;
                              else
                                   y.discapacidades[i] :=false;
                         end;
                    end;
               end;
          end;
          until op=0;
          seek(a,pos);
          write(a,y);
          writeln('Datos modificados correctamente.');
          readkey;
end;

procedure genera_arboles_alum(var a:t_archivo_alumos; var raiz, raiz_2:t_punt);
var
   x:t_dato_alumnos;
   i,j:byte;
begin
  crear_arbol(raiz);
  crear_arbol(raiz_2);
  j:=filesize(a);
  if j<>0 then
  begin
    for i:=0 to j-1 do
    begin
      seek(a,i);
      read(a,x);
      carga_arbol_alum(raiz,x.num_legajo,i);
      carga_arbol_alum(raiz_2,x.ayn,i);
    end;
  end;
end;

procedure carga_arbol_alum(VAR raiz:t_punt; X:t_dato_arbol);
begin
  agregar(raiz,x);
end;  