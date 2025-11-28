unit evaluaciones;
{$mode ObjFPC}{$H+} 
interface      
uses
   Classes, SysUtils, crt, archivos, arboles, validaciones, alumnos;

procedure alta_evaluacion (var arb_ev, arb_leg:t_punt; fecha, legajo:string; a:t_archivo_evaluaciones);
procedure consulta_ev (var arb_ev, arb_leg:t_punt; fecha, legajo:string; a:t_archivo_evaluaciones);
procedure modificar_eval(var a:t_archivo_evaluaciones ; var arb_ev:t_punt, arb_leg:t_punt ; legajo:string; fecha:string);       
procedure genera_arbol_eval(var a:t_archivo_evaluaciones; var raiz:t_punt);
procedure carga_arbol_eval(VAR raiz:t_punt; X:t_dato_arbol);

implementation

procedure cargar_valoracion(var r:t_dato_evaluaciones);
var
    val: byte;
begin
    writeln('Ingrese la valoracion obtenida');
    readln(val);
    while not(valoracion_valida(val)) do
    begin
       writeln('Escriba una valoracion valida: ');
       readln(validda);
    end;
    r.valoracion := val;
end;

procedure cargar_fecha(var r:t_dato_evaluaciones);
var
    fecha: string;
begin
    writeln('Ingrese el dia de la evaluacion (AAAA/MM/DD): ');
    readln(fecha);
    while not(fecha_valida(f)) do
    begin
       writeln('Escriba una fecha valida (AAAA/MM/DD): ');
       readln(fecha);
    end;
    r.fecha_ev := fecha;
end;

procedure cargar_observacion(var r:t_dato_evaluaciones);
var
    observacion: string;
begin
    writeln('Ingrese la observacion');
    readln(observacion);
    r.observacion:=observacion;
end;

procedure cargar_registro (var r:t_dato_evaluaciones, legajo: string);
begin
    r.legajo := legajo;
    cargar_fecha(r);
    cargar_valoracion(r);
    cargar_observacion(r);
end;

procedure agregar_archivo_eval (var a:t_archivo_evaluaciones; legajo:string; pos:integer; var r: t_dato_evaluaciones);
begin
    cargar_registro(r, legajo);
    seek(a, pos);
    write(a, r);
end;

procedure mostrar_registro_ev (x:t_dato_evaluaciones);
var
    i:byte;
begin
    writeln('Legajo: ', x.legajo);
    writeln('fecha: ', x.fecha_ev);
    writeln('valoracion: ', x.valoracion);
    write('Observaciones: ', x.observacion);
end;

procedure alta_evaluacion (var arb_ev, arb_leg:t_punt; fecha, legajo:string; a:t_archivo_evaluaciones);
var
    aux: string;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
    dato_ev: t_dato_arbol;
    op: string;
begin
    encontrado := false;
    pos := 0;
    Preorden(arb_leg, legajo, encontrado, x);
    if encontrado = true then
    begin
        aux := fecha + ' ' + legajo
        Preorden(arb_ev, aux, encontrado, x);
        if encontrado = false then
        begin
            pos := filesize(a);
            agregar_archivo_eval(a, legajo, pos, r);
            dato_ev.clave := r.fecha_ev;
            dato_ev.pos_arch := pos;
            carga_arbol_eval(arb_ev, dato_ev);
            writeln('Evaluacion agregada con exito');
            readkey;
        end
        else
            writeln('Ya existe una evaluacion para esta fecha');
            readkey;
    end
    else
    begin
        writeln('Alumno no encontrado. ¿Desea darlo de alta?');
        case upcase(op) of
            'SI': alta_alumnos(a, legajo, arb_leg, arb_ayn);
        end;
    end;
end;

procedure consulta_ev (var arb_ev, arb_leg:t_punt; fecha, legajo:string; a:t_archivo_evaluaciones);
var
    y: t_dato_evaluaciones;
    pos: integer;
    encontrado: boolean;
    X: t_dato_arbol;
begin
    encontrado := false;
    pos := 0;
    Preorden(arb_leg, legajo, encontrado, x);
    if encontrado = true then
    begin
        pos := x.pos_arch;
        leer_archivo(a, pos, y);
        mostrar_registro_ev(y);    
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

procedure modificar_eval(var a:t_archivo_evaluaciones; var arb_ev:t_punt, arb_leg:t_punt ; legajo:string; fecha:string);
var
    y: t_dato_alumnos;
    x: t_dato_arbol;
    encontrado: boolean;
    pos: integer;
    op: char;
    aux: string;
begin
    encontrado := false;
    pos := 0;
    aux := fecha + ' ' + legajo;
    PREORDEN(arb_ev, aux, encontrado, x);
    if encontrado = true then
    begin
        pos := x.pos_arch;
        repeat
            clrscr;
            leer_archivo(a, pos, y);
            mostrar_registro_ev(y);
            gotoxy(15, 6);                       'hay que cambiarlo para que se vea la informacion actual y al costado las preguntas'
            writeln(¿Que desea modificar?);
            gotoxy(15, 8); 
            writeln('1- Fecha de evaluacion: ');
            gotoxy(15, 10); 
            writeln('2- Valoracion obtenida: ');
            gotoxy(15, 12); 
            writeln('3- Observaciones: ');
            writeln('0- Salir');
            read(op);
            case op of
                1:begin
                    clrscr;
                    writeln('Modificar fecha de evaluacion (AAAA/MM/DD): ');
                    readln(fecha);
                    while not(fecha_valida(fecha)) do
                    begin
                        writeln('ingrese una fecha valida (AAAA/MM/DD)');
                        readln(fecha);
                    end;
                    y.fecha := fecha;
                    suprime(arb_ayn, x);
                    x.clave := fecha + ' ' + legajo;
                    carga_arbol_eval(arb_ayn, x);
                    end;
                2:begin
                    clrscr;
                    writeln('Modificar valoracion obtenida: ');
                    readln(valoracion);
                    while not(valoracion_valida(valoracion)) do
                    begin
                        writeln('ingrese una valoracion valida');
                        readln(valoracion);
                    end;
                    y.valoracion := valoracion;
                end;
                3:begin
                    clrscr;
                    writeln('Modificar observaciones:');
                    readln(observacion);
                    y.observacion := observacion;
                end;
            end;
        until op = 0;
        seek(a, pos);
        write(a, y);
        writeln('Datos modificados correctamente.');
        readkey;
    end;
end;

procedure genera_arbol_eval(var a:t_arch_eval; var raiz:t_punt);
var
   x: t_dato_eval;
   i,j: byte;
begin
  crear_arbol(raiz);
  j := filesize(a);
  if j <> 0 then
  begin
    for i := 0 to j - 1 do
    begin
        seek(a, i);
        read(a, x);
        carga_arbol_eval(raiz, (x.fecha_ev + ' ' + x.legajo), i);
    end;
  end;
end; 

procedure carga_arbol_eval(VAR raiz:t_punt; X:t_dato_arbol);
begin
  agregar_arbol_eval(raiz, x);
end;