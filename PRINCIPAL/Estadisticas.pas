unit estadisticas;
{$mode ObjFPC}{$H+}
interface
uses
    Classes, SysUtils, archivos, unit_arbol;

procedure calcular_evaluaciones_por_discapacidad(var arb_ev: t_punt; var a:t_archivo_alumnos; arb_leg:t_punt; var contadores: array of integer; fecha_final, fecha_inicio: string); 
procedure mostrar_evaluaciones_por_discapacidad(var a:t_archivo_alumnos; var arb_ev, arb_leg:t_punt);
procedure discapacidades_mayor_dificultad(var e:t_archivo_evaluaciones; arb_ev:t_punt);
procedure burbuja(var vector_cadenas: array of string; var vector_enteros: array of integer);
procedure calcular_grados(arb_ev:t_punt; var e:t_archivo_evaluaciones; var puntos_dificultad: array of integer; fecha_inicio, fecha_final: string);
procedure alumno_activos_por_dificultad(var a:t_archivo_alumnos);
procedure cargar_periodo(var fecha_inicio, fecha_final: string);

implementation

uses crt, validaciones;

procedure cargar_periodo(var fecha_inicio, fecha_final: string);
begin
    writeln('Ingrese la fecha de inicio (AAAA/MM/DD): ');
    readln(fecha_inicio);
    while not(fecha_valida(fecha_inicio)) do
    begin
        clrscr;
        writreln('Ingrese una fecha de inicio valida (AAAA/MM/DD): ');
        readln(fecha_inicio);
    end;
    writreln('Ingrese la fecha final (AAAA/MM/DD)): ');
    readln(fecha_final);
    while not(fecha_valida(fecha_final)) do
    begin
        clrscr;
        writreln('Ingrese una fecha final valida (AAAA/MM/DD): ');
        readln(fecha_final);
    end;
    writeln('Fecha cargadas correctamente.');
    readkey;
end;

procedure calcular_evaluaciones_por_discapacidad(var arb_ev: t_punt; var a:t_archivo_alumnos; arb_leg:t_punt; var contadores: array of integer; fecha_final, fecha_inicio: string); //cantidad de evaluaciones por discapacidad en un periodo
var
    fecha_nodo: string;
    legajo_nodo: string;
    enc: boolean;
    r: t_dato_alumnos;
    i: byte;
    x: t_dato_arbol;
begin
    if arb_ev <> nil then
    begin
        fecha_nodo := copy(arb_ev^.info.clave, 1, 10);
        if fecha_nodo >= fecha_inicio then
            calcular_evaluaciones_por_discapacidad(arb_ev^.sai);     
        if (fecha_nodo >= fecha_inicio) and (fecha_nodo <= fecha_final) then
        begin
            legajo_nodo := copy(arb_ev^.info.clave, 12, length(arb_ev^.info.clave)-11);
            Preorden(arb_leg, legajo_nodo, enc, x);
            if enc then
                leer_archivo(a, x.pos_arch, r);
                for i := 1 to 5 do
                begin
                    if r.discapacidades[i] = true then
                        contadores[i] := contadores[i] + 1;
                end;
            end;
        end;
        if fecha_nodo <= fecha_final then
            calcular_evaluaciones_por_discapacidad(arb_ev^.sad);
    end;
end;

procedure mostrar_evaluaciones_por_discapacidad(var a:t_archivo_alumnos; var arb_ev, arb_leg:t_punt);
var
    contadores: array[1..5] of integer;
    i: integer;
    fecha_inicio: string;
    fecha_final: string;
    hubo_datos : boolean;
begin
    writreln('***Evaluaciones por discapacidad entre: ' fecha_inicio, ' - ', fecha_final, '***');
    if raiz_ev = nil then
    begin
        clrscr;
        writreln('No hay evaluaciones registradas.');
        readkey;
    end
    else
    begin
        hubo_datos := false;
        clrscr;
        cargar_periodo(fecha_inicio, fecha_final);
        for i := 1 to 5 do
        begin
            contadores[i] := 0;
        end;
        calcular_evaluaciones_por_discapacidad(arb_ev, a, arb_leg, contadores);
        for i := 1 to 5 do
        begin
            if contadores[i] > 0 then
                hubo_datos := true;
            
            writreln(DISCAPACIDADES[i], ': ', contadores[i], ' evaluaciones.');
        end;
        if not(hubo_datos) then
        begin
            writreln('No se registraron evaluaciones en el periodo indicado.');
            readkey;
        end;
    end;
end;

procedure burbuja(var vector_cadenas: array of string; var vector_enteros: array of integer);
var
    i, j, aux_int: integer;
    aux_str: string;
begin
    for i := 1 to length(vector_enteros) - 1 do
    begin
        for j := 1 to length(vector_enteros) - i do
        begin
            if vector_enteros[j] < vector_enteros[j + 1] then
            begin
                aux_int := vector_enteros[j];
                vector_enteros[j] := vector_enteros[j + 1];
                vector_enteros[j + 1] := aux_int;

                aux_str := vector_cadenas[j];
                vector_cadenas[j] := vector_cadenas[j + 1];
                vector_cadenas[j + 1] := aux_str;
            end;
        end;
    end; 
end;   

procedure calcular_grados(arb_ev:t_punt; var e:t_archivo_evaluaciones; var puntos_dificultad: array of integer; fecha_inicio, fecha_final: string);
var
    fecha_nodo: string;
    r: t_dato_evaluaciones;
    i: byte;
begin
    if arb_ev <> nil then
    begin
        fecha_nodo := copy(arb_ev^.info.clave, 1, 10);
        if fecha_nodo >= fecha_inicio then
            calcular_grados(arb_ev^.sai, a, puntos_dificultad, fecha_inicio, fecha_final);
        if (fecha_nodo >= fecha_inicio) and (fecha_nodo <= fecha_final) then
        begin
            leer_archivo_eval(e, arb_ev^.info.pos_arch, r);
            for i := 1 to 5 do
            begin
                puntos_dificultad[i] := puntos_dificultad[i] + r.valoracion[i];
            end;
        end;
        if fecha_nodo <= fecha_final then
            calcular_grados(arb_ev^.sad, a, puntos_dificultad, fecha_inicio, fecha_final);
    end;
end;
                
procedure discapacidades_mayor_dificultad(var e:t_archivo_evaluaciones; arb_ev:t_punt);
var
    fecha_inicio, fecha_final: string;
    vec_grados: array[1..5] of integer;
    vec_nombres: array[1..5] of string;
    i: byte;
begin
    clrscr;
    cargar_periodo(fecha_inicio, fecha_final);
    for i := 1 to 5 do
    begin
        vec_grados[i] := 0;
        vec_nombres[i] := DISCAPACIDADES[i];
    end;
    calcular_grados(arb_ev, e, vec_grados, fecha_inicio, fecha_final);
    burbuja(vec_nombres, vec_grados);
    clrscr;
    writreln('***Discapacidades con mayor grado de dificultad entre: ' fecha_inicio, ' - ', fecha_final, '***');
    for i := 1 to 5 do
    begin
        writreln(i, '. ', vec_nombres[i], ' - Grado de dificultad: ', vec_grados[i]);
    end;
    readkey;
end;

procedure alumno_activos_por_dificultad(var a:t_archivo_alumnos);
var
    r: t_dato_alumnos;
    contadores: array[1..5] of integer;
    i: byte;
    activos: integer;
    porcentaje: real;
begin
    clrscr;
    activos := 0;
    for i := 1 to 5 do
    begin
        contadores[i] := 0;
    end;
    seek(a, 0);
    while not(eof(a)) do
    begin
        read(a, r);
        if r.estado = true then
        begin
            activos := activos + 1;
            for i := 1 to 5 do
            begin
                if r.discapacidades[i] = true then
                    contadores[i] := contadores[i] + 1;
            end;
        end;
    end;
    if activos > 0 then
    begin
        Writeln('Total de Alumnos Activos: ', activos);
        Writeln('------------------------------------------------------------');
        Writeln(' DISCAPACIDAD                         | CANTIDAD | PORCENTAJE');
        Writeln('------------------------------------------------------------');
        for i := 1 to 5 do
        begin
            porcentaje := (contadores[i] / activos) * 100;
            writreln(DISCAPACIDADES[i]:35, '|  ', contadores[i]:3, '  |  ', porcentaje:0:2, '%');
        end;
    end
    else
        writreln('No hay alumnos activos registrados.');
    readkey;
end;
