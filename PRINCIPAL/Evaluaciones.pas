unit Evaluaciones;
{$mode ObjFPC}{$H+}
interface
uses
    Classes, Crt, SysUtils, Archivos, Usa_archivo, Unit_arbol, Usa_arbol, Validaciones, Alumnos, Interfaz_aux;

procedure cargar_dificultad(var dif: byte);
function ingresar_legajo:string;
function ingresar_fecha: string;
procedure cargar_valoracion(var r:t_dato_evaluaciones; dif_alumno: array of boolean);
procedure cargar_observacion(var r:t_dato_evaluaciones);
procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; fecha:string; dif_alumno: array of boolean);
procedure mostrar_registro_ev (x:t_dato_evaluaciones);
procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; fecha:string; pos:integer; var r: t_dato_evaluaciones; dif_alumno: array of boolean);
procedure alta_evaluacion (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a:t_archivo_alumnos);
procedure consulta_ev (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a: t_archivo_alumnos);
procedure modificar_eval(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
procedure carga_arbol_eval(VAR raiz:t_punt; clave: string; pos: integer);

implementation

procedure cargar_dificultad(var dif: byte);
var
  i: integer;
begin
  clrscr;
  DibujarMarco(15, 5, 70, 17, LightGreen);
  gotoxy(30,6);
  writeln( 'SELECCION DE DIFICULTAD');
  textcolor(LightGreen);
  gotoxy(16, 7);
  writeln('-----------------------------------------------------');
  for i := 1 to 5 do
  begin
     textcolor(White);
     gotoxy(20, 8 + i); write(i, '.');
     textcolor(LightGray);
     write('  ', dificultades[i]);
  end;
  textcolor(green);
  gotoxy(20, 15); write('Ingrese numero (1-5): ');
  textcolor(White);
  readln(dif);
  while (dif < 1) or (dif > 5) do
  begin
     textcolor(LightRed);
     gotoxy(20, 16); write('Reintente (1-5): ');
     textcolor(White);
     readln(dif);
  end;
end;

function ingresar_legajo: string;
var
  l: string;
begin
     clrscr;
        DibujarMarco(15, 6, 65, 13, green);
        TextoCentrado(7, 'GESTION DE EVALUACIONES', White);
        TextoCentrado(8, 'Ingrese legajo', green);
        textcolor(green);
        gotoxy(16, 9); writeln('-------------------------------------------------');
        textcolor(green);
        gotoxy(35, 15); write(' (0 Salir) ');
        gotoxy(20, 11); write('Legajo del alumno: ');
        textcolor(White);
        readln(l);
  while not legajo_valido(l) and (l <> '0') do
  begin
       clrscr;
       DibujarMarco(20, 10, 60, 15, LightGreen);
       TextoCentrado(11, 'INGRESO DE LEGAJO', White);
       textcolor(LightRed);
       gotoxy(25, 13); write('Legajo invalido.');
       textcolor(LightRed);
       gotoxy(25, 14); write('Reintente ');
       textcolor(LightRed);
       gotoxy(22, 15); write('0. VOLVER: ');
       textcolor(White);
       readln(l);
  end;
  ingresar_legajo := l;
end;

function ingresar_fecha: string;
var
  f: string;
begin
  clrscr;
  DibujarMarco(18, 10, 62, 15, LightGreen);
  TextoCentrado(11, 'INGRESO DE FECHA', White);
  textcolor(LightGreen);
  gotoxy(22, 13); write('Fecha (AAAA/MM/DD) ');
  textcolor(LightGreen);
  gotoxy(22, 14); write('0. VOLVER: ');
  textcolor(White);
  readln(f);
  while not (fecha_valida(f)) and (f <> '0') do
  begin
    clrscr;
    DibujarMarco(18, 10, 62, 15, LightGreen);
    TextoCentrado(11, 'INGRESO DE FECHA', White);
    textcolor(LightRed);
    gotoxy(22, 13); write('Fecha invalida.');
    textcolor(LightRed);
    gotoxy(22, 14); write('Reintente (AAAA/MM/DD) ');
    textcolor(LightRed);
    gotoxy(22, 15); write('0. VOLVER: ');
    textcolor(White);
    readln(f);
  end;
  ingresar_fecha := f;
end;

procedure cargar_valoracion(var r:t_dato_evaluaciones; dif_alumno: array of boolean);
var
    val: byte;
    i, linea: integer;
begin
    clrscr;
    DibujarMarco(10, 4, 70, 23, LightGreen);
    TextoCentrado(5, 'VALORACION DE EVALUACION', White);
    TextoCentrado(6, 'Ingrese valores de 0 a 4', LightGreen);
    textcolor(LightGreen);
    gotoxy(11, 7);
    writeln('----------------------------------------------------------');
    textcolor(LightGreen);
    gotoxy(15, 8); writeln('0=Sin dificultad | 4=Maxima dificultad');
    textcolor(LightGreen);
    gotoxy(11, 9);
    writeln('----------------------------------------------------------');
    linea := 11;
    for i := 1 to 5 do
    begin
        if dif_alumno[i-1] = true then
        begin
            textcolor(LightGray);
            gotoxy(15, linea); write(dificultades[i], ': ');
            textcolor(White);
            readln(val);
            while not(valoracion_valida(val)) do
            begin
               textcolor(Red);
               gotoxy(15, linea + 1); write('Ingrese 0-4: ');
               textcolor(White);
               readln(val);
            end;
            r.valoracion[i] := val;
            linea := linea + 2;
        end
        else
        begin
            r.valoracion[i] := 0;
        end;
    end;
    textcolor(LightGreen);
    TextoCentrado(22, 'Valoraciones cargadas correctamente', LightGreen);
    readkey;
end;

procedure cargar_observacion(var r:t_dato_evaluaciones);
var
    observacion: string;
begin
    clrscr;
    DibujarMarco(10, 8, 70, 14, LightGreen);
    TextoCentrado(9, 'OBSERVACIONES', White);
    textcolor(LightGreen);
    TextoCentrado(10, 'Ingrese comentarios adicionales', LightGreen);
    textcolor(LightGreen);
    gotoxy(15, 12); write('Observacion: ');
    textcolor(White);
    readln(observacion);
    r.observacion := observacion;
end;

procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; fecha:string; dif_alumno: array of boolean);
begin
    r.legajo := legajo;
    r.fecha_ev := fecha;
    cargar_valoracion(r, dif_alumno);
    cargar_observacion(r);
end;

procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; fecha:string; pos:integer; var r: t_dato_evaluaciones; dif_alumno: array of boolean);
begin
    cargar_registro(r, legajo, fecha, dif_alumno);
    seek(a, pos);
    write(a, r);
end;

procedure mostrar_registro_ev (x:t_dato_evaluaciones);
var
    i: byte;
    hay_valoraciones: boolean;
begin
    clrscr;
    DibujarMarco(8, 3, 72, 25, LightGreen);
    TextoCentrado(4, 'DETALLE DE EVALUACION', White);
    textcolor(LightGreen);
    gotoxy(9, 5);
    writeln('--------------------------------------------------------------');
    textcolor(Green);
    gotoxy(12, 7); write('Legajo:');
    textcolor(White);
    gotoxy(30, 7); writeln(x.legajo);
    textcolor(Green);
    gotoxy(12, 9); write('Fecha:');
    textcolor(White);
    gotoxy(30, 9); writeln(x.fecha_ev);
    textcolor(Green);
    gotoxy(9, 10);
    writeln('--------------------------------------------------------------');
    textcolor(LightGreen);
    gotoxy(12, 12); writeln('VALORACIONES:');
    hay_valoraciones := false;
    for i := 1 to 5 do
    begin
        if x.valoracion[i] > 0 then
            hay_valoraciones := true;
        textcolor(LightGray);
        gotoxy(15, 12 + i); write(dificultades[i], ': ');
        if x.valoracion[i] = 0 then
            textcolor(LightGreen)
        else if x.valoracion[i] <= 2 then
            textcolor(white)
        else if x.valoracion[i] = 3 then
            textcolor(white)
        else
            textcolor(Red);
        write(x.valoracion[i]);
    end;
    if not hay_valoraciones then
    begin
        textcolor(LightGreen);
        gotoxy(15, 14); write('(Sin valoraciones registradas)');
    end;
    textcolor(LightGreen);
    gotoxy(9, 19);
    writeln('--------------------------------------------------------------');
    textcolor(LightGreen);
    gotoxy(12, 21); write('Observaciones:');
    textcolor(LightGreen);
    gotoxy(12, 22); writeln(x.observacion);
    textcolor(White);
    gotoxy(20, 26); write('Presione ENTER para continuar...');
    readln;
end;

procedure alta_evaluacion(var arb_ev, arb_leg, arb_ayn: t_punt; fecha: string; legajo: string; var e: t_archivo_evaluaciones; var a: t_archivo_alumnos);
var
   aux: string;
   pos: integer;
   encontrado: boolean;
   x: t_dato_arbol;
   r: t_dato_evaluaciones;
   r_alum: t_dato_alumnos;
begin
   Preorden(arb_leg, legajo, encontrado, x);
   leer_archivo_1(a, x.pos_arch, r_alum);
   aux := fecha + ' ' + legajo;
   Preorden(arb_ev, aux, encontrado, x);
   if encontrado = false then
   begin
      pos := filesize(e);
      agregar_archivo_eval(e, legajo, fecha, pos, r, r_alum.dificultades);
      carga_arbol_eval(arb_ev, aux, pos);
      clrscr;
      textcolor(LightGreen);
      gotoxy(25, 12); writeln('---------------------------------');
      gotoxy(25, 13); writeln(' EVALUACION REGISTRADA CON EXITO ');
      gotoxy(25, 14); writeln('---------------------------------');
      textcolor(White);
      gotoxy(20, 16); write('Presione cualquier tecla para continuar...');
      readkey;
   end
   else
   begin
      clrscr;
      textcolor(LightRed);
      gotoxy(25, 12); writeln('---------------------------------');
      gotoxy(25, 13); writeln('    YA EXISTE UNA EVALUACION     ');
      gotoxy(25, 14); writeln('        PARA ESTA FECHA          ');
      gotoxy(25, 15); writeln('---------------------------------');
      textcolor(White);
      gotoxy(20, 17); write('Presione cualquier tecla para continuar...');
      readkey;
   end;
end;

procedure consulta_ev(var arb_ev, arb_leg, arb_ayn: t_punt; fecha: string; legajo: string; var e: t_archivo_evaluaciones; var a: t_archivo_alumnos);
var
   y: t_dato_evaluaciones;
   pos: integer;
   encontrado: boolean;
   x: t_dato_arbol;
   op: char;
   aux: string;
begin
   encontrado := false;
   pos := 0;
   aux := fecha + ' ' + legajo;
   Preorden(arb_ev, aux, encontrado, x);
   if encontrado then
   begin
      pos := x.pos_arch;
      leer_archivo_2(e, pos, y);
      mostrar_registro_ev(y);
   end
   else
   begin
      clrscr;
      DibujarMarco(15, 10, 65, 15, LightGreen);
      textcolor(LightRed);
      TextoCentrado(11, 'EVALUACION NO ENCONTRADA', White);
      textcolor(LightGreen);
      gotoxy(20, 13); write('Desea crear una evaluacion? (S/N): ');
      textcolor(White);
      readln(op);

      if UpCase(op) = 'S' then
      begin
          clrscr;
          alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
          Preorden(arb_ev, aux, encontrado, x);
          if encontrado then
              consulta_ev(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
      end;
   end;
end;

procedure modificar_eval(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
var
   y: t_dato_evaluaciones;
   x, x_alum: t_dato_arbol;
   encontrado, enc_alum: boolean;
   pos, op, opcion: integer;
   aux_clave_vieja, nueva_obs: string;
   nueva_val, indice, cant_opciones, i: byte;
   disc_op: char;
   r_alum: t_dato_alumnos;
   mapa_opciones: array[1..5] of byte;
begin
   encontrado := false;
   aux_clave_vieja := fecha + ' ' + legajo;
   PREORDEN(arb_ev, aux_clave_vieja, encontrado, x);
   if encontrado then
   begin
       PREORDEN(arb_leg, legajo, enc_alum, x_alum);
       leer_archivo_1(a, x_alum.pos_arch, r_alum);
       pos := x.pos_arch;
       leer_archivo_2(e, pos, y);
       repeat
           clrscr;
           DibujarMarco(10, 2, 70, 22, LightGreen);
           TextoCentrado(3, 'MODIFICACION DE EVALUACION', White);
           textcolor(LightGreen);
           gotoxy(22, 4); write('Legajo: ', legajo, ' | Fecha: ', y.fecha_ev);
           textcolor(white); gotoxy(18, 18); write('0.'); textcolor(LightGray); write('  Guardar y Salir');
           textcolor(LightGreen); gotoxy(18, 20); write('Opcion: ');
           textcolor(White); readln(op);

           case op of
              1: begin
                        repeat
                           clrscr;
                           DibujarMarco(12, 6, 74, 20, Green);
                           TextoCentrado(7, 'MODIFICAR VALORACION', White);
                           cant_opciones := 0;
                           for i := 1 to 5 do
                           begin
                               if r_alum.dificultades[i] then
                               begin
                                   inc(cant_opciones);
                                   mapa_opciones[cant_opciones] := i;
                                   textcolor(White); gotoxy(20, 10 + cant_opciones); write(cant_opciones, '.');
                                   textcolor(LightGray); write('  ', DIFICULTADES[i]);
                                   textcolor(LightGreen); write(' [', y.valoracion[i], ']');
                               end;
                           end;
                           textcolor(white); gotoxy(20, 10 + cant_opciones + 2); write('0. Volver');
                           textcolor(LightGreen); gotoxy(20, 10 + cant_opciones + 4); write('Opcion: ');
                           textcolor(White); readln(opcion);
                           if (opcion >= 1) and (opcion <= cant_opciones) then
                           begin
                               indice := mapa_opciones[opcion];
                               textcolor(LightGreen);
                               gotoxy(15, 12 + cant_opciones + 6); write('Nuevo valor (0-4) para ', DIFICULTADES[indice], ': ');
                               textcolor(White); readln(nueva_val);
                               if valoracion_valida(nueva_val) then
                               begin
                                   y.valoracion[indice] := nueva_val;
                                   textcolor(LightGreen); gotoxy(25, 12 + cant_opciones + 6); write('Valor actualizado!');
                               end
                               else
                               begin
                                   textcolor(LightRed); gotoxy(30, 12 + cant_opciones + 6); write('Valor invalido');
                               end;
                               readkey;
                           end;
                           until opcion = 0;
              end;
              2: begin
                        clrscr;
                        DibujarMarco(10, 9, 90, 16, LightGreen);
                        TextoCentrado(10, 'MODIFICAR OBSERVACIONES', White);
                        textcolor(LightGreen); gotoxy(15, 12); write('Observacion actual:');
                        textcolor(LightGray); gotoxy(15, 13); writeln(y.observacion);
                        textcolor(LightGreen); gotoxy(15, 14); write('Nueva observacion: ');
                        textcolor(White); readln(nueva_obs);
                        y.observacion := nueva_obs;
                        textcolor(LightGreen); TextoCentrado(15, 'Observacion actualizada!', LightGreen);
                        readkey;
              end;
           end;
       until op = 0;
       escribir_archivo_2(e, pos, y);
       clrscr;
   end
   else
   begin
       clrscr;
       DibujarMarco(15, 10, 65, 15, LightGreen);
       textcolor(LightRed);
       TextoCentrado(11, 'EVALUACION NO ENCONTRADA', White);
       textcolor(green);
       gotoxy(20, 13); write('Desea crear una evaluacion? (S/N): ');
       textcolor(White);
       readln(disc_op);
       if UpCase(disc_op) = 'S' then
       begin
           clrscr;
           alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
       end;
   end;
end;

procedure carga_arbol_eval(VAR raiz:t_punt; clave: string; pos: integer);
var
  dato: t_dato_arbol;
begin
  dato.clave := clave;
  dato.pos_arch := pos;
  agregar(raiz, dato);
end;
end.      