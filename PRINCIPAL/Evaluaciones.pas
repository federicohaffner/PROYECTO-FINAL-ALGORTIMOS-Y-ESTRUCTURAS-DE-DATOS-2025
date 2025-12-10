unit Evaluaciones;
{$mode ObjFPC}{$H+}
interface
uses
    Classes, crt, SysUtils, archivos, usa_archivo, unit_arbol, usa_arbol, validaciones, alumnos, interfaz_aux;

procedure alta_evaluacion (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a:t_archivo_alumnos);
procedure consulta_ev (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a: t_archivo_alumnos);
procedure modificar_eval(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
procedure genera_arbol_eval(var e:t_archivo_evaluaciones; var raiz:t_punt);
procedure carga_arbol_eval(VAR raiz:t_punt; clave: string; pos: integer);
procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; fecha:string; disc_alumno: array of boolean);
procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; fecha:string; pos:integer; var r: t_dato_evaluaciones; disc_alumno: array of boolean);
procedure mostrar_registro_ev (x:t_dato_evaluaciones);
procedure cargar_valoracion(var r:t_dato_evaluaciones; disc_alumno: array of boolean);
{procedure cargar_fecha(var r:t_dato_evaluaciones); }
procedure cargar_observacion(var r:t_dato_evaluaciones);
function ingresar_legajo: string;
function ingresar_fecha: string;
procedure cargar_discapacidad(var disc: byte);

implementation

procedure cargar_discapacidad(var disc: byte);
var
  i: integer;
begin
  clrscr;
  DibujarMarco(15, 5, 65, 18, LightGreen);
  TextoCentrado(6, 'SELECCION DE DISCAPACIDAD', White);
  textcolor(LightGreen);
  gotoxy(16, 7);
  writeln('-------------------------------------------------');
  for i := 1 to 5 do
  begin
     textcolor(White);
     gotoxy(20, 8 + i); write(i, '.');
     textcolor(LightGray);
     write('  ', DISCAPACIDADES[i]);
  end;
  textcolor(green);
  gotoxy(20, 15); write('Ingrese numero (1-5): ');
  textcolor(White);
  readln(disc);
  while (disc < 1) or (disc > 5) do
  begin
     textcolor(LightRed);
     gotoxy(20, 16); write('Numero invalido. Reintente (1-5): ');
     textcolor(White);
     readln(disc);
  end;
end;

function ingresar_legajo: string;
var
  l: string;
begin
  clrscr;
  DibujarMarco(20, 10, 60, 15, LightGreen);
  TextoCentrado(11, 'INGRESO DE LEGAJO', White);
  textcolor(LightGreen);
  gotoxy(25, 13); write('Legajo (8 digitos) ');
  textcolor(LightGreen);
  gotoxy(22, 14); write('0. VOLVER: ');
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

procedure cargar_valoracion(var r:t_dato_evaluaciones; disc_alumno: array of boolean);
var
    val: byte;
    i, linea: integer;
begin
    clrscr;
    DibujarMarco(10, 4, 70, 20, LightGreen);
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
        if disc_alumno[i-1] = true then
        begin
            textcolor(LightGray);
            gotoxy(15, linea); write(DISCAPACIDADES[i], ': ');
            textcolor(White);
            readln(val);

            while not(valoracion_valida(val)) do
            begin
               textcolor(LightRed);
               gotoxy(15, linea + 1); write('Valor invalido.');
               textcolor(LightRed);
               gotoxy(15, linea + 2); write('Ingrese 0-4: ');
               textcolor(White);
               readln(val);
            end;
            r.valoracion[i] := val;
            linea := linea + 3;
        end
        else
        begin
            r.valoracion[i] := 0;
        end;
    end;
    textcolor(LightGreen);
    TextoCentrado(19, 'Valoraciones cargadas correctamente', LightGreen);
    readkey;
end;

{procedure cargar_fecha(var r:t_dato_evaluaciones);
var
    fecha: string;
begin
    clrscr;
    DibujarMarco(18, 10, 62, 15, LightGreen);
    TextoCentrado(11, 'FECHA DE EVALUACION', White);
    textcolor(LightGreen);
    gotoxy(22, 13); write('Fecha (AAAA/MM/DD): ');
    textcolor(White);
    readln(fecha);
    while not(fecha_valida(fecha)) do
    begin
       textcolor(LightRed);
       gotoxy(22, 14); write('Fecha invalida. Reintente: ');
       textcolor(White);
       readln(fecha);
    end;
    r.fecha_ev := fecha;
end;}

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

procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; fecha:string; disc_alumno: array of boolean);
begin
    r.legajo := legajo;
    r.fecha_ev := fecha;
    cargar_valoracion(r, disc_alumno);
    cargar_observacion(r);
end;

procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; fecha:string; pos:integer; var r: t_dato_evaluaciones; disc_alumno: array of boolean);
begin
    cargar_registro(r, legajo, fecha, disc_alumno);
    seek(a, pos);
    write(a, r);
end;

procedure mostrar_registro_ev (x:t_dato_evaluaciones);
var
    i: byte;
    hay_valoraciones: boolean;
begin
    clrscr;
    DibujarMarco(8, 3, 72, 23, LightGreen);
    TextoCentrado(4, 'DETALLE DE EVALUACION', White);
    textcolor(LightGreen);
    gotoxy(9, 5);
    writeln('--------------------------------------------------------------');
    textcolor(LightGreen);
    gotoxy(12, 7); write('Legajo:');
    textcolor(White);
    gotoxy(30, 7); writeln(x.legajo);
    textcolor(Yellow);
    gotoxy(12, 9); write('Fecha:');
    textcolor(White);
    gotoxy(30, 9); writeln(x.fecha_ev);
    textcolor(LightGreen);
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
        gotoxy(15, 13 + i); write(DISCAPACIDADES[i], ': ');

        if x.valoracion[i] = 0 then
            textcolor(LightGreen)
        else if x.valoracion[i] <= 2 then
            textcolor(white)
        else if x.valoracion[i] = 3 then
            textcolor(white)
        else
            textcolor(LightRed);

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
    gotoxy(12, 20); write('Observaciones:');
    textcolor(LightGreen);
    gotoxy(12, 21); writeln(x.observacion);
    textcolor(White);
    gotoxy(20, 22); write('Presione ENTER para continuar...');
    readln;
end;

procedure alta_evaluacion (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a:t_archivo_alumnos);
var
    aux: string;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
    dato_ev: t_dato_arbol;
    op: string;
    r: t_dato_evaluaciones;
    r_alum: t_dato_alumnos;
begin
    encontrado := false;
    pos := 0;
    Preorden(arb_leg, legajo, encontrado, x);
    if encontrado = true then
    begin
        leer_archivo_1(a, x.pos_arch, r_alum);
        if r_alum.estado = false then
        begin
          clrscr;
          DibujarMarco(15, 10, 65, 15, LightGreen);
          textcolor(LightGreen);
          TextoCentrado(11, 'ALUMNO DADO DE BAJA', LightGreen);
          textcolor(LightGray);
          TextoCentrado(12, 'No se puede evaluar un alumno inactivo', LightGray);
          textcolor(LightGreen);
          gotoxy(20, 14); write('Desea reactivarlo? (S/N): ');
          textcolor(White);
          readln(op);
          if upcase(op) = 'S' then
          begin
              clrscr;
              alta_alumnos(a, legajo, arb_leg, arb_ayn);
              Preorden(arb_leg, legajo, encontrado, x);
              if encontrado = true and r_alum.estado = true then
                alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a)
              else
                writeln('No se pudo reactivar el alumno.');
                readkey;
            end;
        end
        else
        begin
          aux := fecha + ' ' + legajo;
          Preorden(arb_ev, aux, encontrado, x);
          if encontrado = false then
          begin
              pos := filesize(e);
              agregar_archivo_eval(e, legajo, fecha, pos, r, r_alum.discapacidades);
              dato_ev.clave := r.fecha_ev;
              dato_ev.pos_arch := pos;
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
    end
    else
    begin
        clrscr;
        DibujarMarco(15, 10, 65, 15, LightGreen);
        textcolor(LightRed);
        TextoCentrado(11, 'ALUMNO NO ENCONTRADO', White);
        textcolor(LightGreen);
        gotoxy(20, 13); write('Desea darlo de alta? (S/N): ');
        textcolor(White);
        readln(op);
        if upcase(op) = 'S' then
        begin
            alta_alumnos(a, legajo, arb_leg, arb_ayn);
        end;
    end;
end;


procedure consulta_ev (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones; var a:t_archivo_alumnos);
var
    y: t_dato_evaluaciones;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
    op: char;
    aux: string;
begin
    encontrado := false;
    pos := 0;
    aux := fecha + ' ' + legajo;
    Preorden(arb_ev, aux, encontrado, x);
    if encontrado = true then
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
        if upcase(op) = 'S' then
        begin
            clrscr;
            alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e,a);
            Preorden(arb_ev, aux, encontrado, x);
            if encontrado = true then
                consulta_ev(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a)
            else
                writeln('No se pudo crear la evaluacion.');
            readkey;
        end;
    end;
end;

procedure modificar_eval(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
var
    y: t_dato_evaluaciones;
    x, dato_nuevo, x_alum: t_dato_arbol;
    encontrado, enc_alum: boolean;
    pos, op, opcion: integer;
    aux_clave_vieja, nueva_fecha, nueva_obs: string;
    nueva_val, indice_disc, indice, cant_opciones, i: byte;
    disc_op: char;
    r_alum: t_dato_alumnos;
    mapa_opciones: array[1..5] of byte;
begin
    encontrado := false;
    pos := 0;
    aux_clave_vieja := fecha + ' ' + legajo;
    PREORDEN(arb_ev, aux_clave_vieja, encontrado, x);
    if encontrado = true then
    begin
        pos := x.pos_arch;
        leer_archivo_2(e, pos, y);
        enc_alum := false;
        PREORDEN(arb_leg, legajo, enc_alum, x_alum);
        if enc_alum then
        begin
           leer_archivo_1(a, x_alum.pos_arch, r_alum);
            repeat
                clrscr;
                DibujarMarco(10, 2, 70, 24, LightGreen);
                TextoCentrado(3, 'MODIFICACION DE EVALUACION', White);
                textcolor(LightGreen);
                gotoxy(22, 4); write('Legajo: ', legajo, ' | Fecha: ', y.fecha_ev);
                textcolor(LightGreen);
                gotoxy(11, 5);
                writeln('----------------------------------------------------------');
                textcolor(LightGreen);
                gotoxy(15, 7); write('DATOS ACTUALES:');
                textcolor(LightGray);
                gotoxy(15, 8); write('Fecha: ', y.fecha_ev);
                gotoxy(15, 9); write('Observaciones: ', y.observacion);
                textcolor(LightGreen);
                gotoxy(11, 10);
                writeln('----------------------------------------------------------');
                textcolor(LightGreen);
                gotoxy(15, 12); write('Que desea modificar?');
                textcolor(White);
                gotoxy(18, 14); write('1.');
                textcolor(LightGray);
                write('  Fecha de evaluacion');
                gotoxy(18, 16);
                textcolor(White);
                write('2.');
                textcolor(LightGray);
                write('  Valoracion obtenida');
                gotoxy(18, 18);
                textcolor(White);
                write('3.');
                textcolor(LightGray);
                write('  Observaciones');
                gotoxy(18, 20);
                textcolor(white);
                write('0.');
                textcolor(LightGray);
                write('  Guardar y Salir');

                textcolor(LightGreen);
                gotoxy(28, 22); write('Opcion: ');
                textcolor(White);
                readln(op);
                case op of
                    1: begin
                        clrscr;
                        DibujarMarco(15, 9, 65, 16, LightGreen);
                        TextoCentrado(10, 'MODIFICAR FECHA', White);
                        textcolor(LightGreen);
                        gotoxy(20, 12); write('Fecha actual: ');
                        textcolor(LightGray);
                        write(y.fecha_ev);
                        textcolor(LightGreen);
                        gotoxy(20, 13); write('Nueva fecha (AAAA/MM/DD): ');
                        textcolor(White);
                        readln(nueva_fecha);

                        while not(fecha_valida(nueva_fecha)) do
                        begin
                            clrscr;
                            DibujarMarco(15, 9, 65, 16, LightGreen);
                            textcolor(LightRed);
                            gotoxy(20, 14); write('Fecha invalida.');
                            textcolor(LightRed);
                            gotoxy(20, 14); write('Reintente (AAAA/MM/DD): ');
                            textcolor(White);
                            readln(nueva_fecha);
                        end;

                        gotoxy(20, 14); write('                                          ');
                        y.fecha_ev := nueva_fecha;
                        x.clave := aux_clave_vieja;
                        suprime(arb_ev, x);
                        aux_clave_vieja := nueva_fecha + ' ' + legajo;
                        dato_nuevo.clave := aux_clave_vieja;
                        dato_nuevo.pos_arch := pos;
                        agregar_arbol_eval(arb_ev, dato_nuevo);
                        escribir_archivo_2(e, pos, y);
                        textcolor(LightGreen);
                        TextoCentrado(15, 'Fecha actualizada!', LightGreen);
                        readkey;
                    end;
                    2: begin
                        repeat
                            clrscr;
                            DibujarMarco(12, 6, 68, 22, Green);
                            TextoCentrado(7, 'MODIFICAR VALORACION', White);
                            textcolor(LightGreen);
                            gotoxy(18, 9); writeln('Seleccione la discapacidad a editar:');
                            cant_opciones := 0;
                            for i := 1 to 5 do
                            begin
                                if r_alum.discapacidades[i] then
                                begin
                                    inc(cant_opciones);
                                    mapa_opciones[cant_opciones] := i;
                                    textcolor(White);
                                    gotoxy(20, 10 + cant_opciones); write(cant_opciones, '.');
                                    textcolor(LightGray);
                                    write('  ', DISCAPACIDADES[i]);
                                    textcolor(LightGreen);
                                    write(' [', y.valoracion[i], ']');
                                end;
                            end;
                                textcolor(white);
                                gotoxy(20, 12 + cant_opciones + 2); write('0. Volver');
                                textcolor(LightGreen);
                                gotoxy(20, 12 + cant_opciones + 4); write('Opcion: ');
                                textcolor(White);
                                readln(opcion);
                                if (opcion >= 1) and (op <= cant_opciones) then
                                begin
                                    indice := mapa_opciones[opcion];
                                    textcolor(LightGreen);
                                    gotoxy(15, 12 + cant_opciones + 6); write('                                                      ');
                                    gotoxy(15, 12 + cant_opciones + 6); write('Nuevo valor (0-4) para ', DISCAPACIDADES[indice], ': ');
                                    textcolor(White);
                                    readln(nueva_val);
                                    if valoracion_valida(nueva_val) then
                                    begin
                                        y.valoracion[indice] := nueva_val;
                                        escribir_archivo_2(e, pos, y);
                                        gotoxy(15, 12 + cant_opciones + 6); write('                                                                    ');
                                        textcolor(LightGreen);
                                        gotoxy(25, 12 + cant_opciones + 6); write('Valoracion actualizada y guardada!');
                                    end
                                    else
                                    begin
                                        gotoxy(15, 12 + cant_opciones + 6); write('                                                      ');
                                        textcolor(LightRed);
                                        gotoxy(30, 12 + cant_opciones + 6); write('Valor invalido');
                                    end;
                                    readkey;
                                end
                                else
                                begin
                                if (opcion <> 0) then
                                begin
                                    textcolor(LightRed);
                                    gotoxy(30, 12 + cant_opciones + 6); write('Opcion fuera de rango');
                                    readkey;
                                end;
                            end;
                        until opcion = 0;
                    end;
                3: begin
                    clrscr;
                    DibujarMarco(10, 9, 70, 16, LightGreen);
                    TextoCentrado(10, 'MODIFICAR OBSERVACIONES', White);
                    textcolor(LightGreen);
                    gotoxy(15, 12); write('Observacion actual:');
                    textcolor(LightGray);
                    gotoxy(15, 13); writeln(y.observacion);
                    textcolor(LightGreen);
                    gotoxy(15, 14); write('Nueva observacion: ');
                    textcolor(White);
                    readln(nueva_obs);
                    y.observacion := nueva_obs;
                    textcolor(LightGreen);
                    TextoCentrado(15, 'Observacion actualizada!', LightGreen);
                    readkey;
                end;
                end;
            until op = 0;
        escribir_archivo_2(e, pos, y);
        clrscr;
        end;
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
        if upcase(disc_op) = 'S' then
        begin
            clrscr;
            alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
        end;
    end;
end;

procedure genera_arbol_eval(var e:t_archivo_evaluaciones; var raiz:t_punt);
var
   x: t_dato_evaluaciones;
   i, j: integer;
begin
  crear_arbol(raiz);
  j := filesize(e);
  if j <> 0 then
  begin
    for i := 0 to j - 1 do
    begin
        seek(e, i);
        read(e, x);
        carga_arbol_eval(raiz, (x.fecha_ev + ' ' + x.legajo), i);
    end;
  end;
end;

procedure carga_arbol_eval(VAR raiz:t_punt; clave: string; pos: integer);
var
  dato: t_dato_arbol;
begin
  dato.clave := clave;
  dato.pos_arch := pos;
  agregar_arbol_eval(raiz, dato);
end;
end.      