unit evaluaciones;
{$mode ObjFPC}{$H+} 
interface      
uses
    Classes, crt, SysUtils, archivos, usa_archivo, unit_arbol, usa_arbol, validaciones, alumnos, interfaz_aux;

procedure alta_evaluacion (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones);
procedure consulta_ev (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones);
procedure modificar_eval(var e: t_archivo_evaluaciones; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
procedure genera_arbol_eval(var e:t_archivo_evaluaciones; var raiz:t_punt);
procedure carga_arbol_eval(VAR raiz:t_punt; clave: string; pos: integer);
procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; disc_alumno: array of boolean);
procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; pos:integer; var r: t_dato_evaluaciones; disc_alumno: array of boolean);
procedure mostrar_registro_ev (x:t_dato_evaluaciones);
procedure cargar_valoracion(var r:t_dato_evaluaciones; disc_alumno: array of boolean);
procedure cargar_fecha(var r:t_dato_evaluaciones);
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
  DibujarMarco(15, 5, 65, 18, LightBlue);
  TextoCentrado(6, 'SELECCION DE DISCAPACIDAD', White);
  textcolor(Blue);
  gotoxy(16, 7);
  writeln('-------------------------------------------------');
  for i := 1 to 5 do
  begin
     textcolor(White);
     gotoxy(20, 8 + i); write(i, '.');
     textcolor(LightGray);
     write('  ', DISCAPACIDADES[i]);
  end;
  textcolor(Yellow);
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
  DibujarMarco(20, 10, 60, 15, LightBlue);
  TextoCentrado(11, 'INGRESO DE LEGAJO', White);
  textcolor(Yellow);
  gotoxy(25, 13); write('Legajo (8 digitos): ');
  textcolor(White);
  readln(l);
  while not legajo_valido(l) do
  begin
    textcolor(LightRed);
    gotoxy(25, 14); write('Legajo invalido. Reintente: ');
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
  DibujarMarco(18, 10, 62, 15, LightBlue);
  TextoCentrado(11, 'INGRESO DE FECHA', White);
  textcolor(Yellow);
  gotoxy(22, 13); write('Fecha (AAAA/MM/DD): ');
  textcolor(White);
  readln(f);
  while not fecha_valida(f) do
  begin
    textcolor(LightRed);
    gotoxy(22, 14); write('Fecha invalida. Reintente: ');
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
    DibujarMarco(10, 4, 70, 20, LightBlue);
    TextoCentrado(5, 'VALORACION DE EVALUACION', White);
    TextoCentrado(6, 'Ingrese valores de 0 a 4', LightCyan);
    textcolor(Blue);
    gotoxy(11, 7);
    writeln('----------------------------------------------------------');
    textcolor(Yellow);
    gotoxy(15, 8); writeln('0=Sin dificultad | 4=Maxima dificultad');
    textcolor(Blue);
    gotoxy(11, 9);
    writeln('----------------------------------------------------------');
    linea := 11;
    for i := 1 to 5 do
    begin
        if disc_alumno[i] = true then
        begin
            textcolor(LightGray);
            gotoxy(15, linea); write(DISCAPACIDADES[i], ': ');
            textcolor(White);
            readln(val);

            while not(valoracion_valida(val)) do
            begin
               textcolor(LightRed);
               gotoxy(15, linea + 1); write('Valor invalido. Ingrese 0-4: ');
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
    TextoCentrado(19, 'Valoraciones cargadas correctamente', LightGreen);
    readkey;
end;

procedure cargar_fecha(var r:t_dato_evaluaciones);
var
    fecha: string;
begin
    clrscr;
    DibujarMarco(18, 10, 62, 15, LightBlue);
    TextoCentrado(11, 'FECHA DE EVALUACION', White);
    textcolor(Yellow);
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
end;

procedure cargar_observacion(var r:t_dato_evaluaciones);
var
    observacion: string;
begin
    clrscr;
    DibujarMarco(10, 8, 70, 14, LightBlue);
    TextoCentrado(9, 'OBSERVACIONES', White);
    textcolor(LightCyan);
    TextoCentrado(10, 'Ingrese comentarios adicionales', LightCyan);
    textcolor(Yellow);
    gotoxy(15, 12); write('Observacion: ');
    textcolor(White);
    readln(observacion);
    r.observacion := observacion;
end;

procedure cargar_registro (var r:t_dato_evaluaciones; legajo: string; disc_alumno: array of boolean);
begin
    r.legajo := legajo;
    cargar_fecha(r);
    cargar_valoracion(r, disc_alumno);
    cargar_observacion(r);
end;

procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; pos:integer; var r: t_dato_evaluaciones; disc_alumno: array of boolean);
begin
    cargar_registro(r, legajo, disc_alumno);
    seek(a, pos);
    write(a, r);
end;

procedure mostrar_registro_ev (x:t_dato_evaluaciones);
var
    i: byte;
    hay_valoraciones: boolean;
begin
    clrscr;
    DibujarMarco(8, 3, 72, 23, LightBlue);
    TextoCentrado(4, 'DETALLE DE EVALUACION', White);
    textcolor(Blue);
    gotoxy(9, 5);
    writeln('--------------------------------------------------------------');
    textcolor(Yellow);
    gotoxy(12, 7); write('Legajo:');
    textcolor(White);
    gotoxy(30, 7); writeln(x.legajo);
    textcolor(Yellow);
    gotoxy(12, 9); write('Fecha:');
    textcolor(White);
    gotoxy(30, 9); writeln(x.fecha_ev);
    textcolor(Blue);
    gotoxy(9, 10);
    writeln('--------------------------------------------------------------');
    textcolor(Yellow);
    gotoxy(12, 12); writeln('VALORACIONES:');
    hay_valoraciones := false;
    for i := 1 to 5 do
    begin
        if x.valoracion[i] > 0 then
            hay_valoraciones := true;
            
        textcolor(LightGray);
        gotoxy(15, 13 + i); write(DISCAPACIDADES[i], ': ');
        
        if x.valoracion[i] = 0 then
            textcolor(LightCyan)
        else if x.valoracion[i] <= 2 then
            textcolor(LightGreen)
        else if x.valoracion[i] = 3 then
            textcolor(Yellow)
        else
            textcolor(LightRed);
            
        write(x.valoracion[i]);
    end;
    if not hay_valoraciones then
    begin
        textcolor(LightCyan);
        gotoxy(15, 14); write('(Sin valoraciones registradas)');
    end;
    textcolor(Blue);
    gotoxy(9, 19);
    writeln('--------------------------------------------------------------');
    textcolor(Yellow);
    gotoxy(12, 20); write('Observaciones:');
    textcolor(LightGray);
    gotoxy(12, 21); writeln(x.observacion);
    textcolor(White);
    gotoxy(20, 22); write('Presione ENTER para continuar...');
    readln;
end;

procedure alta_evaluacion (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones);
var
    aux: string;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
    dato_ev: t_dato_arbol;
    op: string;
    r: t_dato_evaluaciones;
    r_alum: t_dato_alumnos;
    a: t_archivo_alumnos;
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
          DibujarMarco(15, 10, 65, 15, LightBlue);
          textcolor(Yellow);
          TextoCentrado(11, 'ALUMNO DADO DE BAJA', Yellow);
          textcolor(LightGray);
          TextoCentrado(12, 'No se puede evaluar un alumno inactivo', LightGray);
          textcolor(Yellow);
          gotoxy(20, 14); write('¿Desea reactivarlo? (SI/NO): ');
          textcolor(White);
          readln(op);
          if upcase(op) = 'SI' then
          begin
              alta_alumnos(a, legajo, arb_leg, arb_ayn);
          end;
          exit;
        end;
        aux := fecha + ' ' + legajo;
        Preorden(arb_ev, aux, encontrado, x);
        if encontrado = false then
        begin
            pos := filesize(e);
            agregar_archivo_eval(e, legajo, pos, r, r_alum.discapacidades);
            dato_ev.clave := r.fecha_ev;
            dato_ev.pos_arch := pos;
            carga_arbol_eval(arb_ev, aux, pos);
            
            clrscr;
            textcolor(LightGreen);
            gotoxy(25, 12); writeln('╔════════════════════════════════╗');
            gotoxy(25, 13); writeln('║ EVALUACION REGISTRADA CON EXITO║');
            gotoxy(25, 14); writeln('╚════════════════════════════════╝');
            textcolor(White);
            gotoxy(20, 16); write('Presione cualquier tecla para continuar...');
            readkey;
        end
        else
        begin
            clrscr;
            textcolor(LightRed);
            gotoxy(25, 12); writeln('╔════════════════════════════════╗');
            gotoxy(25, 13); writeln('║  YA EXISTE UNA EVALUACION      ║');
            gotoxy(25, 14); writeln('║  PARA ESTA FECHA               ║');
            gotoxy(25, 15); writeln('╚════════════════════════════════╝');
            textcolor(White);
            gotoxy(20, 17); write('Presione cualquier tecla para continuar...');
            readkey;
        end;
    end
    else
    begin
        clrscr;
        DibujarMarco(15, 10, 65, 15, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'ALUMNO NO ENCONTRADO', White);
        textcolor(Yellow);
        gotoxy(20, 13); write('¿Desea darlo de alta? (SI/NO): ');
        textcolor(White);
        readln(op);
        if upcase(op) = 'SI' then
        begin
            alta_alumnos(a, legajo, arb_leg, arb_ayn);
        end;
    end;
end;


procedure consulta_ev (var arb_ev, arb_leg, arb_ayn:t_punt; fecha: string; legajo:string; var e:t_archivo_evaluaciones);
var
    y: t_dato_evaluaciones;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
    op: char;
    a: t_archivo_alumnos;
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
        DibujarMarco(15, 10, 65, 15, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'EVALUACION NO ENCONTRADA', White);
        textcolor(Yellow);
        gotoxy(20, 13); write('¿Desea crear una evaluacion? (S/N): ');
        textcolor(White);
        readln(op);
        if upcase(op) = 'S' then
        begin
            clrscr;
            alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e);
        end;
    end;
end;

procedure modificar_eval(var e: t_archivo_evaluaciones; var arb_ev, arb_leg, arb_ayn: t_punt; legajo: string; fecha: string);
var
    y: t_dato_evaluaciones;
    x, dato_nuevo: t_dato_arbol;
    encontrado: boolean;
    pos: integer;
    op: integer;
    aux_clave_vieja, nueva_fecha: string;
    nueva_obs: string;
    nueva_val, indice_disc: byte;
    disc_op: char;
begin
    encontrado := false;
    pos := 0;
    aux_clave_vieja := fecha + ' ' + legajo;
    PREORDEN(arb_ev, aux_clave_vieja, encontrado, x);
    if encontrado = true then
    begin
        pos := x.pos_arch;
        leer_archivo_2(e, pos, y);
        repeat
            clrscr;
            DibujarMarco(10, 2, 70, 24, LightBlue);
            TextoCentrado(3, 'MODIFICACION DE EVALUACION', White);
            textcolor(LightCyan);
            gotoxy(22, 4); write('Legajo: ', legajo, ' | Fecha: ', fecha);
            textcolor(Blue);
            gotoxy(11, 5);
            writeln('----------------------------------------------------------');
            textcolor(Yellow);
            gotoxy(15, 7); write('DATOS ACTUALES:');
            textcolor(LightGray);
            gotoxy(15, 8); write('Fecha: ', y.fecha_ev);
            gotoxy(15, 9); write('Observaciones: ', y.observacion);
            textcolor(Blue);
            gotoxy(11, 10);
            writeln('----------------------------------------------------------');   
            textcolor(Yellow);
            gotoxy(15, 12); write('¿Que desea modificar?');
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
            textcolor(LightRed);
            write('0.');
            textcolor(LightGray);
            write('  Guardar y Salir');
            
            textcolor(Yellow);
            gotoxy(28, 22); write('Opcion: ');
            textcolor(White);
            readln(op);
            case op of
                1: begin
                    clrscr;
                    DibujarMarco(15, 9, 65, 16, LightBlue);
                    TextoCentrado(10, 'MODIFICAR FECHA', White);
                    textcolor(Yellow);
                    gotoxy(20, 12); write('Fecha actual: ');
                    textcolor(LightGray);
                    write(y.fecha_ev);
                    textcolor(Yellow);
                    gotoxy(20, 13); write('Nueva fecha (AAAA/MM/DD): ');
                    textcolor(White);
                    readln(nueva_fecha);
                    while not(fecha_valida(nueva_fecha)) do
                    begin
                        textcolor(LightRed);
                        gotoxy(20, 14); write('Fecha invalida. Reintente: ');
                        textcolor(White);
                        readln(nueva_fecha);
                    end;
                    y.fecha_ev := nueva_fecha;
                    x.clave := aux_clave_vieja;
                    suprime(arb_ev, x);
                    aux_clave_vieja := nueva_fecha + ' ' + legajo;
                    dato_nuevo.clave := aux_clave_vieja;
                    dato_nuevo.pos_arch := pos;
                    agregar_arbol_eval(arb_ev, dato_nuevo);
                    textcolor(LightGreen);
                    TextoCentrado(15, '¡Fecha actualizada!', LightGreen);
                    readkey;
                   end;
                2: begin
                    clrscr;
                    DibujarMarco(12, 6, 68, 19, LightBlue);
                    TextoCentrado(7, 'MODIFICAR VALORACION', White);
                    textcolor(Yellow);
                    gotoxy(18, 9); writeln('Seleccione la discapacidad:');
                    for indice_disc := 1 to 5 do
                    begin
                        textcolor(White);
                        gotoxy(20, 10 + indice_disc); write(indice_disc, '.');
                        textcolor(LightGray);
                        write('  ', DISCAPACIDADES[indice_disc]);
                    end;
                    textcolor(Yellow);
                    gotoxy(20, 16); write('Numero (1-5): ');
                    textcolor(White);
                    readln(indice_disc);
                    if (indice_disc >= 1) and (indice_disc <= 5) then
                    begin
                        textcolor(Yellow);
                        gotoxy(20, 17); write('Valor actual: ');
                        textcolor(LightGray);
                        write(y.valoracion[indice_disc]);
                        textcolor(Yellow);
                        gotoxy(20, 18); write('Nuevo valor (0-4): ');
                        textcolor(White);
                        readln(nueva_val);
                        if valoracion_valida(nueva_val) then
                        begin
                            y.valoracion[indice_disc] := nueva_val;
                            textcolor(LightGreen);
                            TextoCentrado(18, '¡Valoracion actualizada!', LightGreen);
                        end
                        else
                        begin
                            textcolor(LightRed);
                            TextoCentrado(18, 'Valor invalido', LightRed);
                        end;
                    end;
                    readkey;
                   end;
                3: begin
                    clrscr;
                    DibujarMarco(10, 9, 70, 16, LightBlue);
                    TextoCentrado(10, 'MODIFICAR OBSERVACIONES', White);
                    textcolor(Yellow);
                    gotoxy(15, 12); write('Observacion actual:');
                    textcolor(LightGray);
                    gotoxy(15, 13); writeln(y.observacion);
                    textcolor(Yellow);
                    gotoxy(15, 14); write('Nueva observacion: ');
                    textcolor(White);
                    readln(nueva_obs);
                    y.observacion := nueva_obs;
                    textcolor(LightGreen);
                    TextoCentrado(15, '¡Observacion actualizada!', LightGreen);
                    readkey;
                   end;
            end;
        until op = 0;
        escribir_archivo_2(e, pos, y); 
        clrscr;
        textcolor(LightGreen);
        gotoxy(25, 12); writeln('╔════════════════════════════════╗');
        gotoxy(25, 13); writeln('║  DATOS MODIFICADOS CON EXITO   ║');
        gotoxy(25, 14); writeln('╚════════════════════════════════╝');
        textcolor(White);
        gotoxy(20, 16); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        clrscr;
        DibujarMarco(15, 10, 65, 15, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'EVALUACION NO ENCONTRADA', White);
        textcolor(Yellow);
        gotoxy(20, 13); write('¿Desea crear una evaluacion? (S/N): ');
        textcolor(White);
        readln(disc_op);
        if upcase(disc_op) = 'S' then
        begin
            clrscr;
            alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e);
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