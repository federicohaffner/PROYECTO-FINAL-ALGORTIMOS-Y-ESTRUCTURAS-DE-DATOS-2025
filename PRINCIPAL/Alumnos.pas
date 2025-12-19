unit Alumnos;
{$mode ObjFPC}{$H+}
interface
uses
     Classes, SysUtils, Archivos, Usa_arbol, Validaciones, Unit_arbol, Usa_archivo, Interfaz_aux, Crt;

function Estado_Alumno(leg: string; arb: t_punt; var a: t_archivo_alumnos): byte;
function Resolver_Estado_Alumno(leg: string; var a: t_archivo_alumnos; var arb_leg, arb_ayn: t_punt): boolean;
procedure cargar_ayn(var r:t_dato_alumnos);
procedure cargar_fecha_nac (var r:t_dato_alumnos);
procedure cargar_dif (var r:t_dato_alumnos);
procedure cargar_registro (var r:t_dato_alumnos; legajo: string);
procedure mostrar_registro_al (x:t_dato_alumnos);
procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer; var r:t_dato_alumnos);
function buscar_legajo(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn: t_punt ; legajo:string):boolean;
procedure alta_alumnos (var a: t_archivo_alumnos; legajo: string; var arb_leg: t_punt; var arb_ayn: t_punt);
procedure baja_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure consulta_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure modificar_alumno(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure carga_arbol_alum(VAR raiz:t_punt; id: string; pos: integer);

implementation

function Estado_Alumno(leg: string; arb: t_punt; var a: t_archivo_alumnos): byte;
var
    enc: boolean;
    x: t_dato_arbol;
    reg: t_dato_alumnos;
begin
    preorden(arb, leg, enc, x);
    if not enc then
        estado_alumno := 0
    else
    begin
        leer_archivo_1(a, x.pos_arch, reg);
        if reg.estado then
            estado_alumno := 2
        else
            estado_alumno := 1;
    end;
end;

function Resolver_Estado_Alumno(leg: string; var a: t_archivo_alumnos; var arb_leg, arb_ayn: t_punt): boolean;
var
    enc: boolean;
    x: t_dato_arbol;
    reg: t_dato_alumnos;
    respuesta: char;
    estado: byte; { 0: No existe, 1: Baja, 2: Activo }
begin
    Resolver_Estado_Alumno := False;
    estado := estado_alumno(leg, arb_leg, a);
    case estado of
         0:begin
                clrscr;
                DibujarMarco(15, 6, 65, 13, green);
                TextoCentrado(7, 'ALUMNO NO ENCONTRADO', White);
                textcolor(LightGray); TextoCentrado(8, 'Legajo: ' + leg, LightGreen);
                textcolor(green);
                gotoxy(16, 9); writeln('-------------------------------------------------');
                textcolor(LightGreen); gotoxy(20, 11); write('Desea dar de alta este alumno? (S/N): ');
                readln(respuesta);

                if UpCase(respuesta) = 'S' then
                begin
                     clrscr;
                     alta_alumnos(a, leg, arb_leg, arb_ayn);
                     preorden(arb_leg, leg, enc, x);
                     if enc then
                     begin
                          estado := 2;
                          resolver_estado_alumno := true;
                     end;
                end;
         end;
         1:begin
                clrscr;
                DibujarMarco(20, 10, 60, 14, LightGreen);
                TextoCentrado(11, 'ALUMNO DE BAJA', LightGreen);
                textcolor(LightGray); TextoCentrado(12, 'El alumno existe pero esta inactivo.', LightGreen);
                textcolor(LightGreen); gotoxy(25, 14); write('Desea reactivarlo? (S/N): ');
                readln(respuesta);
                if UpCase(respuesta) = 'S' then
                begin
                  clrscr;
                  alta_alumnos(a, leg, arb_leg, arb_ayn);
                  leer_archivo_1(a, x.pos_arch, reg);
                  if reg.estado then
                  begin
                     estado := 2;
                     resolver_estado_alumno := true;
                  end;
                end;
         end;
         2: resolver_estado_alumno := true;
    end;
end;

procedure cargar_ayn(var r:t_dato_alumnos);
var
   ayn: string;
begin
     clrscr;
     DibujarMarco(15, 6, 65, 13, green);
     TextoCentrado(8, 'APELLIDO Y NOMBRE', White);
     textcolor(green);
     gotoxy(16, 9); writeln('-------------------------------------------------');
     textcolor(LightGreen);
     gotoxy(20, 11); write('Apellido y Nombre: ');
     textcolor(White);
     readln(ayn);
     while not(escadena(ayn)) do
     begin
          clrscr;
          DibujarMarco(15, 8, 65, 14, Green);
          textcolor(LightRed);
          gotoxy(20, 11); write('Nombre invalido.');
          textcolor(LightRed);
          gotoxy(20, 12); write('Intente nuevamente: ');
          textcolor(White);
          readln(ayn);
     end;
     r.ayn := ayn;
end;

procedure cargar_fecha_nac (var r:t_dato_alumnos);
var
   f: string[10];
begin
     clrscr;
     DibujarMarco(15, 6, 65, 13, green);
     TextoCentrado(8, 'FECHA DE NACIMIENTO', White);
     textcolor(green);
     gotoxy(16, 9); writeln('-------------------------------------------------');
     textcolor(LightGreen);
     gotoxy(20, 11); write('Fecha (AAAA/MM/DD): ');
     textcolor(White);
     readln(f);
     while not(fecha_valida(f)) do
     begin
       clrscr;
       DibujarMarco(15, 8, 65, 14, Green);
       textcolor(LightRed);
       gotoxy(20, 11); write('Fecha invalida.');
       textcolor(LightRed);
       gotoxy(20, 12); write('Intente nuevamente (AAAA/MM/DD): ');
       textcolor(White);
       readln(f);
     end;
     r.fecha_nac := f;
end;

procedure cargar_dif (var r:t_dato_alumnos);
var
   i:byte;
   op: char;
begin
     clrscr;
     DibujarMarco(10, 4, 70, 22, Green);
     TextoCentrado(5, 'REGISTRO DE DIFICULTADES', White);
     TextoCentrado(6, 'Marque (S/N)', LightGreen);
     textcolor(Green);
     gotoxy(11, 7);
     writeln('----------------------------------------------------------');
     for i:= 1 to 5 do
     begin
       textcolor(LightGray);
       gotoxy(15, 8 + (i * 2));
       write(dificultades[i], ': ');
       textcolor(White);
       readln(op);
       while (upcase(op) <> 'S') and (upcase(op) <> 'N') do
       begin
         textcolor(LightRed);
         gotoxy(15, 9 + (i * 2));
         write('Reintente (S/N): ');
         textcolor(White);
         readln(op);
       end;
       if upcase(op) = 'S' then
          r.dificultades[i] := true
       else
           r.dificultades[i] := false;
     end;
end;

procedure cargar_registro (var r:t_dato_alumnos; legajo: string);
begin
     r.legajo := legajo;
     cargar_ayn(r);
     cargar_fecha_nac(r);
     cargar_dif(r);
     r.estado := true;
end;

procedure mostrar_registro_al (x:t_dato_alumnos);
var
     i: byte;
     primera: boolean;
begin
     clrscr;
     DibujarMarco(10, 3, 70, 23, Green);
     TextoCentrado(4, 'INFORMACION DEL ALUMNO', White);
     textcolor(Green);
     gotoxy(11, 5);
     writeln('----------------------------------------------------------');
     textcolor(LightGreen);
     gotoxy(15, 7); write('Legajo: ');
     textcolor(White);
     gotoxy(35, 7); writeln(x.legajo);
     textcolor(LightGreen);
     gotoxy(15, 9); write('Apellido y Nombre: ');
     textcolor(White);
     gotoxy(35, 9); writeln(x.ayn);
     textcolor(LightGreen);
     gotoxy(15, 11); write('Fecha Nacimiento: ');
     textcolor(White);
     gotoxy(35, 11); writeln(x.fecha_nac);
     textcolor(LightGreen);
     gotoxy(15, 13); write('Estado: ');
     if x.estado = true then
     begin
          textcolor(LightGreen);
          gotoxy(35, 13); writeln('Activo');
     end
     else
     begin
          textcolor(LightRed);
          gotoxy(35, 13); writeln('De Baja');
     end;
     textcolor(LightGreen);
     gotoxy(15, 15); writeln('Dificultades que presenta: ');
     primera := true;
     for i:= 1 to 5 do
     begin
          if x.dificultades[i] = true then
          begin
               textcolor(LightGray);
               gotoxy(18, 15 + i);
               write('- ', DIFICULTADES[i]);
               primera := false;
          end;
     end;
     if primera then
     begin
          textcolor(LightGreen);
          gotoxy(18, 17);
          write('(Ninguna registrada)');
     end;
     textcolor(White);
end;

procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer; var r: t_dato_alumnos);
begin
     cargar_registro(r, legajo);
     escribir_archivo_1(a, pos, r)
end;

function buscar_legajo(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt; legajo:string):boolean;
var
     y: t_dato_alumnos;
     x: t_dato_arbol;
     encontrado: boolean;
     pos: integer;
begin
     buscar_legajo := false;
     encontrado := false;
     pos := 0;
     preorden(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch;
          leer_archivo_1(a, pos, y);
          if y.estado then
          begin
               buscar_legajo := true;
          end;
     end;
end;

procedure alta_alumnos (var a: t_archivo_alumnos; legajo: string; var arb_leg, arb_ayn: t_punt);
var
     pos: integer;
     dato_ayn, x, dato_leg: t_dato_arbol;
     r: t_dato_alumnos;
     encontrado: boolean;
begin
     encontrado := false;
     pos := 0;
     preorden(arb_leg, legajo, encontrado, x);

     if encontrado = false then
     begin
          pos:=filesize(a);
          agregar_archivo_alumno(a, legajo, pos, r);
          carga_arbol_alum(arb_leg, r.legajo, pos);
          carga_arbol_alum(arb_ayn, r.ayn, pos);
          clrscr;
          textcolor(LightGreen);
          gotoxy(25, 12); writeln('---------------------------------');
          gotoxy(25, 13); writeln('   ALUMNO REGISTRADO CON EXITO   ');
          gotoxy(25, 14); writeln('---------------------------------');
          textcolor(White);
          gotoxy(23, 16); write('Presione una tecla para continuar...');
          readkey;
     end
     else
     begin
          pos := x.pos_arch;
          leer_archivo_1(a, pos, r);
          clrscr;
          DibujarMarco(15, 8, 65, 18, Green);
          TextoCentrado(9, 'REGISTRO ENCONTRADO', White);
          textcolor(LightGray);
          gotoxy(20, 11); writeln('Legajo: ', r.legajo);
          gotoxy(20, 12); writeln('Nombre: ', r.ayn);
          if r.estado = true then
          begin
               textcolor(LightRed);
               TextoCentrado(14, 'El alumno ya se encuentra activo.', LightRed);
               textcolor(White);
               gotoxy(23, 16); write('Presione una tecla para salir...');
               readkey;
          end
          else
          begin
               r.estado := true;
               escribir_archivo_1(a, pos, r);
               clrscr;
               textcolor(LightGreen);
               gotoxy(25, 12); writeln('---------------------------------');
               gotoxy(25, 13); writeln('   ALUMNO REACTIVADO CON EXITO   ');
               gotoxy(25, 14); writeln('---------------------------------');
               textcolor(White);
               gotoxy(23, 16); write('Presione una tecla para continuar...');
               readkey;
          end;
     end;
end;

procedure baja_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y: t_dato_alumnos;
     x: t_dato_arbol;
     encontrado: boolean;
     pos: integer;
begin
     encontrado := false;
     pos := 0;
     preorden(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch ;
          leer_archivo_1(a, pos, y);
          if y.estado = true then
          begin
               y.estado := false;
               escribir_archivo_1(a, pos, y);
               clrscr;
               mostrar_registro_al (y);
               textcolor(Red);
               gotoxy(75, 3); writeln('---------------------------------');
               gotoxy(75, 4); writeln('| ALUMNO DADO DE BAJA CON EXITO  | ');
               gotoxy(75, 5); writeln('---------------------------------');
               textcolor(White);
               gotoxy(75, 7); write('Presione una tecla para continuar...');
               readkey;
          end
          else
          begin
               clrscr;
               textcolor(Red);
               gotoxy(25, 12); writeln('---------------------------------');
               gotoxy(25, 13); writeln('   ALUMNO YA ESTA DADO DE BAJA   ');
               gotoxy(25, 14); writeln('---------------------------------');
               textcolor(White);
               gotoxy(23, 16); write('Presione una tecla para continuar...');
               readkey;
          end;
     end
     else
     begin
          clrscr;
          textcolor(Red);
          gotoxy(25, 12); writeln('---------------------------------');
          gotoxy(25, 13); writeln('     ALUMNO NO ENCONTRADO          ');
          gotoxy(25, 14); writeln('---------------------------------');
          textcolor(White);
          gotoxy(23, 16); write('Presione una tecla para continuar...');
          readkey;
     end;
end;

procedure consulta_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y: t_dato_alumnos;
     x: t_dato_arbol;
     encontrado: boolean;
     pos: integer;
     op: char;
begin
     encontrado := false;
     pos := 0;
     preorden(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch;
          leer_archivo_1(a, pos, y);
          mostrar_registro_al(y);
     end
     else
     begin
          clrscr;
          DibujarMarco(15, 10, 65, 16, Green);
          textcolor(LightRed);
          TextoCentrado(11, 'ALUMNO NO ENCONTRADO', White);
          textcolor(LightGreen);
          gotoxy(20, 13); write('Desea agregarlo? (S/N): ');
          textcolor(White);
          readln(op);
          if upcase(op)='S'  then
          begin
               clrscr;
               alta_alumnos(a, legajo, arb_leg, arb_ayn);
               preorden(arb_leg, legajo, encontrado, x);
               if encontrado = true then
                    consulta_alumnos(a, arb_leg, arb_ayn, legajo)
               else
                    writeln('Error al agregar alumno.');
               readkey;
          end;
     end;
end;

procedure modificar_alumno(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
var
     y: t_dato_alumnos;
     x: t_dato_arbol;
     encontrado: boolean;
     pos: integer;
     opcion, i: byte;
     ayn: string;
     fecha: string;
     dif: char;
begin
     encontrado := false;
     pos := 0;
     preorden(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch;
          leer_archivo_1(a, pos, y);
          repeat
               clrscr;
               mostrar_registro_al(y);
               DibujarMarco(75, 3, 107, 17, green);
               gotoxy(80, 4);
               textcolor(white);
               writeln('MODIFICACION DE ALUMNO');
               textcolor(green);
               gotoxy(76, 5);
               writeln('--------------------------------');
               textcolor(White);
               gotoxy(78, 7); textcolor(White); write('1.'); textcolor(LightGray); write('  Apellido y Nombre');
               gotoxy(78, 9); textcolor(White); write('2.'); textcolor(LightGray); write('  Fecha Nacimiento');
               gotoxy(78, 11); textcolor(white); write('3.'); textcolor(LightGray); write('  Dificultades');
               gotoxy(78, 13); textcolor(white); write('0.'); textcolor(LightGray); write('  Salir');
               textcolor(green);
               gotoxy(78, 15); write('Opcion: ');
               textcolor(White);
               readln(opcion);
               case opcion of
                    1: begin
                         clrscr;
                         mostrar_registro_al(y);
                         DibujarMarco(75, 3, 119, 12, green);
                         gotoxy(78, 4);
                         textcolor(white);
                         writeln('MODIFICAR APELLIDO Y NOMBRE');
                         textcolor(green);
                         gotoxy(76, 5);
                         writeln('--------------------------------------------');
                         textcolor(Green);
                         gotoxy(77, 6); write('Apellido y nombre actual: ');
                         textcolor(LightGray);
                         gotoxy(77,7);
                         writeln(y.ayn);
                         textcolor(LightGreen);
                         gotoxy(77, 9); write('Apellido y nombre nuevo: ');
                         gotoxy(77, 10);
                         textcolor(White);
                         readln(ayn);
                         while not (nombre_valido(ayn)) do
                         begin
                              textcolor(Red);
                              gotoxy(77, 9); write('Reintente:                ');
                              gotoxy(77, 10);
                              textcolor(White);
                              readln(ayn);
                         end;
                         x.clave := y.ayn;
                         suprime(arb_ayn, x);
                         y.ayn := ayn;
                         carga_arbol_alum(arb_ayn, y.ayn, pos);
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         gotoxy(88, 13);
                         writeln('Campo actualizado!');
                         readkey;
                       end;
                    2: begin
                         clrscr;
                         mostrar_registro_al(y);
                         DibujarMarco(75, 3, 119, 12, green);
                         gotoxy(83, 4);
                         textcolor(white);
                         writeln('MODIFICAR FECHA DE NACIMIENTO');
                         textcolor(green);
                         gotoxy(76, 5);
                         writeln('--------------------------------------------');
                         gotoxy(77, 6); write('Fecha de nacimiento cargada: ');
                         textcolor(LightGray);
                         gotoxy(77,7);
                         writeln(y.fecha_nac);
                         textcolor(LightGreen);
                         gotoxy(77, 9); write('Fecha de nacimiento por actualizar: ');
                         gotoxy(77, 10);
                         textcolor(White);
                         readln(fecha);
                         while not(fecha_valida(fecha)) do
                         begin
                              textcolor(RED);
                              gotoxy(77,9); write('Reintente (AAAA/MM/DD):            ');
                              gotoxy(77, 10);
                              textcolor(White);
                              readln(fecha);
                         end;
                         y.fecha_nac := fecha;
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         gotoxy(88, 13);
                         writeln('Campo actualizado!');
                         readkey;
                       end;
                    3: begin
                         clrscr;
                         DibujarMarco(75, 10, 119, 14, white);
                         gotoxy(78, 11);
                         textcolor(Green);
                         writeln('En verde las dificultades que posee');
                         gotoxy(78,12);
                         textcolor(white);
                         writeln('----------------------------------------');
                         gotoxy(78, 13);
                         textcolor(red);
                         writeln('En rojo las dificultades que no posee');
                         DibujarMarco(10, 4, 70, 22, Green);
                         TextoCentrado(5, 'MODIFICAR DIFICULTADES', Green);
                         TextoCentrado(6, 'Marque (S/N)', White);
                         textcolor(Green);
                         gotoxy(11, 7);
                         writeln('----------------------------------------------------------');
                         for i := 1 to 5 do
                         begin
                              if y.dificultades[i] = true then
                              textcolor(green)
                              else
                              textcolor(Red);
                              gotoxy(15, 8 + (i * 2));
                              write(dificultades[i], ' (S/N): ');
                              readln(dif);
                              while (upcase(dif) <> 'S') and (upcase(dif) <> 'N') do
                              begin
                                   textcolor(red);
                                   gotoxy(15, 9 + (i * 2));
                                   write('Reintente(S/N): ');
                                   textcolor(White);
                                   readln(dif);
                              end;
                              if upcase(dif) = 'S' then
                                   y.dificultades[i] := true
                              else
                                   y.dificultades[i] := false;
                         end;
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         TextoCentrado(20, 'Discapacidades actualizadas!', LightGreen);
                         readln;
                       end;
               end;
          until opcion = 0;
     end
     else
     begin
          clrscr;
          textcolor(LightRed);
          gotoxy(25, 12); writeln('---------------------------------');
          gotoxy(25, 13); writeln('   ALUMNO NO ENCONTRADO          ');
          gotoxy(25, 14); writeln('---------------------------------');
          textcolor(White);
          gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
          readkey;
     end;
end;

procedure carga_arbol_alum(VAR raiz:t_punt; id: string; pos: integer);
var
  dato_a_guardar: t_dato_arbol;
begin
  dato_a_guardar.clave := id;
  dato_a_guardar.pos_arch := pos;
  agregar(raiz, dato_a_guardar);
end;
end.    