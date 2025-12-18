unit Alumnos;
{$mode ObjFPC}{$H+}
interface
uses
     Classes, SysUtils, Archivos, Ua_arbol, Validaciones, Unit_arbol, Usa_archivo, Interfaz_aux, Crt;

procedure cargar_ayn(var r:t_dato_alumnos);
procedure cargar_fecha_nac (var r:t_dato_alumnos);
procedure cargar_disc (var r:t_dato_alumnos);
procedure cargar_registro (var r:t_dato_alumnos; legajo: string);
procedure mostrar_registro_al (x:t_dato_alumnos);
procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer; var r:t_dato_alumnos);
function buscar_legajo(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn: t_punt ; legajo:string):boolean;
procedure alta_alumnos (var a: t_archivo_alumnos; legajo: string; var arb_leg: t_punt; var arb_ayn: t_punt);
procedure baja_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure consulta_alumnos(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure modificar_alumno(var a:t_archivo_alumnos; arb_leg:t_punt; var arb_ayn:t_punt ; legajo:string);
procedure genera_arboles_alum(var a:t_archivo_alumnos; var raiz, raiz_2:t_punt);
procedure carga_arbol_alum(VAR raiz:t_punt; id: string; pos: integer);

implementation


procedure cargar_ayn(var r:t_dato_alumnos);
var
   ayn: string;
begin
     clrscr;
     DibujarMarco(15, 8, 65, 14, Green);
     TextoCentrado(9, 'APELLIDO Y NOMBRE', White);
     textcolor(LightGreen);
     gotoxy(20, 11); write('Apellido y Nombre: ');
     textcolor(White);
     readln(ayn);
     while not(nombre_valido(ayn)) do
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
     DibujarMarco(15, 8, 65, 14, Green);
     TextoCentrado(9, 'FECHA DE NACIMIENTO', White);
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

procedure cargar_disc (var r:t_dato_alumnos);
var
   i:byte;
   op: char;
begin
     clrscr;
     DibujarMarco(10, 4, 70, 22, Green);
     TextoCentrado(5, 'REGISTRO DE DISCAPACIDADES', White);
     TextoCentrado(6, 'Marque (S/N)', LightGreen);
     textcolor(Green);
     gotoxy(11, 7);
     writeln('----------------------------------------------------------');
     for i:= 1 to 5 do
     begin
       textcolor(LightGray);
       gotoxy(15, 8 + (i * 2));
       write(discapacidades[i], ': ');
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
          r.discapacidades[i] := true
       else
           r.discapacidades[i] := false;
     end;
end;

procedure cargar_registro (var r:t_dato_alumnos; legajo: string);
begin
     r.legajo := legajo;
     cargar_ayn(r);
     fecha_nac(r);
     tiene_disc(r);
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
          if x.discapacidades[i] = true then
          begin
               textcolor(LightGray);
               gotoxy(18, 16 + i);
               write('- ', DISCAPACIDADES[i]);
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
     gotoxy(25, 22); write('Presione ENTER para continuar...');
     readln;
end;



procedure agregar_archivo_alumno (var a:t_archivo_alumnos; legajo:string; pos:integer; var r: t_dato_alumnos);
begin
     cargar_registro(r, legajo);
     seek(a, pos);
     write(a, r);
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
     PREORDEN(arb_leg, legajo, encontrado, x);
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
     PREORDEN(arb_leg, legajo, encontrado, x);

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
          gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
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
               gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
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
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch ;
          leer_archivo_1(a, pos, y);
          if y.estado = true then
          begin
               y.estado := false;
               escribir_archivo_1(a, pos, y);
               clrscr;
               textcolor(LightGreen);
               gotoxy(25, 12); writeln('---------------------------------');
               gotoxy(25, 13); writeln('  ALUMNO DADO DE BAJA CON EXITO  ');
               gotoxy(25, 14); writeln('---------------------------------');
               textcolor(White);
               gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
               readkey;
          end
          else
          begin
               clrscr;
               textcolor(LightGreen);
               gotoxy(25, 12); writeln('---------------------------------');
               gotoxy(25, 13); writeln('   ALUMNO YA ESTA DADO DE BAJA   ');
               gotoxy(25, 14); writeln('---------------------------------');
               textcolor(White);
               gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
               readkey;
          end;
     end
     else
     begin
          clrscr;
          textcolor(LightRed);
          gotoxy(25, 12); writeln('---------------------------------');
          gotoxy(25, 13); writeln('     ALUMNO NO ENCONTRADO          ');
          gotoxy(25, 14); writeln('---------------------------------');
          textcolor(White);
          gotoxy(23, 16); write('Presione cualquier tecla para continuar...');
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
     PREORDEN(arb_leg, legajo, encontrado, x);
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
               PREORDEN(arb_leg, legajo, encontrado, x);
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
     op, i: byte;
     ayn: string;
     fecha: string;
     disc: char;
begin
     encontrado := false;
     pos := 0;
     PREORDEN(arb_leg, legajo, encontrado, x);
     if encontrado = true then
     begin
          pos := x.pos_arch;
          leer_archivo_1(a, pos, y);
          repeat
               clrscr;
               DibujarMarco(10, 2, 70, 24, Green);
               TextoCentrado(3, 'MODIFICACION DE ALUMNO', White);
               textcolor(LightGreen);
               gotoxy(30, 4); write('Legajo: ', legajo);
               textcolor(Green);
               gotoxy(11, 5);
               writeln('----------------------------------------------------------');
               textcolor(LightGreen);
               gotoxy(15, 7); write('DATOS ACTUALES:');
               textcolor(LightGray);
               gotoxy(15, 8); write('Apellido y Nombre: ', y.ayn);
               gotoxy(15, 9); write('Fecha Nacimiento : ', y.fecha_nac);
               gotoxy(15, 10); write('Estado           : ');
               if y.estado then
               begin
                    textcolor(LightGreen);
                    write('Activo');
               end
               else
               begin
                    textcolor(LightRed);
                    write('De Baja');
               end;
               textcolor(Green);
               gotoxy(11, 11);
               writeln('----------------------------------------------------------');
               textcolor(LightGreen);
               gotoxy(15, 13); write('Que desea modificar?');
               textcolor(White);
               gotoxy(18, 15); write('1.');
               textcolor(LightGray);
               write('  Apellido y Nombre');
               gotoxy(18, 17);
               textcolor(White);
               write('2.');
               textcolor(LightGray);
               write('  Fecha de Nacimiento');
               gotoxy(18, 19);
               textcolor(White);
               write('3.');
               textcolor(LightGray);
               write('  Dificultades');
               gotoxy(18, 21);
               textcolor(white);
               write('0.');
               textcolor(LightGray);
               write('  Guardar y Salir');
               textcolor(LightGreen);
               gotoxy(28, 23); write('Opcion: ');
               textcolor(White);
               readln(op);
               case op of
                    1: begin
                         clrscr;
                         DibujarMarco(15, 8, 65, 16, Green);
                         TextoCentrado(9, 'MODIFICAR APELLIDO Y NOMBRE', White);
                         textcolor(LightGreen);
                         gotoxy(20, 11); write('Valor actual: ');
                         textcolor(LightGray);
                         write(y.ayn);
                         textcolor(LightGreen);
                         gotoxy(20, 13); write('Nuevo valor: ');
                         textcolor(White);
                         readln(ayn);
                         while not(nombre_valido(ayn)) do
                         begin
                              clrscr;
                              DibujarMarco(15, 8, 65, 14, Green);
                              textcolor(LightRed);
                              gotoxy(20, 13); write('Nombre invalido.');
                              textcolor(LightRed);
                              gotoxy(20, 14); write('Reintente: ');
                              textcolor(White);
                              readln(ayn);
                         end;
                         x.clave := y.ayn;
                         suprime(arb_ayn, x);
                         y.ayn := ayn;
                         carga_arbol_alum(arb_ayn, y.ayn, pos);
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         TextoCentrado(15, 'Campo actualizado!', LightGreen);;
                         readln;
                       end;
                    2: begin
                         clrscr;
                         DibujarMarco(15, 8, 65, 16, Green);
                         TextoCentrado(9, 'MODIFICAR FECHA DE NACIMIENTO', White);
                         textcolor(LightGreen);
                         gotoxy(20, 11); write('Valor actual: ');
                         textcolor(LightGray);
                         write(y.fecha_nac);
                         textcolor(LightGreen);
                         gotoxy(20, 13); write('Nuevo valor (AAAA/MM/DD): ');
                         textcolor(White);
                         readln(fecha);
                         while not(fecha_valida(fecha)) do
                         begin
                              clrscr;
                              DibujarMarco(15, 8, 65, 14, Green);
                              textcolor(LightRed);
                              gotoxy(20, 13); write('Fecha invalida.');
                              textcolor(LightRed);
                              gotoxy(20, 14); write('Reintente (AAAA/MM/DD): ');
                              textcolor(White);
                              readln(fecha);
                         end;
                         y.fecha_nac := fecha;
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         TextoCentrado(15, 'Campo actualizado!', LightGreen);
                         readln;
                       end;
                    3: begin
                         clrscr;
                         DibujarMarco(10, 4, 70, 22, Green);
                         TextoCentrado(5, 'MODIFICAR DISCAPACIDADES', White);
                         TextoCentrado(6, 'Marque (S/N)', LightGreen);
                         textcolor(Green);
                         gotoxy(11, 7);
                         writeln('----------------------------------------------------------');

                         for i := 1 to 5 do
                         begin
                              textcolor(LightGray);
                              gotoxy(15, 8 + (i * 2));
                              write(DISCAPACIDADES[i], ' (S/N): ');
                              textcolor(White);
                              readln(disc);
                              while (upcase(disc) <> 'S') and (upcase(disc) <> 'N') do
                              begin
                                   textcolor(LightRed);
                                   gotoxy(15, 9 + (i * 2));
                                   write('Reintente(S/N): ');
                                   textcolor(White);
                                   readln(disc);
                              end;
                              if upcase(disc) = 'S' then
                                   y.discapacidades[i] := true
                              else
                                   y.discapacidades[i] := false;
                         end;
                         escribir_archivo_1(a, pos, y);
                         textcolor(LightGreen);
                         TextoCentrado(20, 'Discapacidades actualizadas!', LightGreen);
                         readln;
                       end;
               end;
          until op = 0;
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



procedure genera_arboles_alum(var a:t_archivo_alumnos; var raiz, raiz_2:t_punt);
var
   x: t_dato_alumnos;
   i,j: byte;
begin
  crear_arbol(raiz);
  crear_arbol(raiz_2);
  j:=filesize(a);
  if j <> 0 then
  begin
    for i := 0 to j - 1 do
    begin
      seek(a, i);
      read(a, x);
      carga_arbol_alum(raiz,x.legajo, i);
      carga_arbol_alum(raiz_2, x.ayn,i);
    end;
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