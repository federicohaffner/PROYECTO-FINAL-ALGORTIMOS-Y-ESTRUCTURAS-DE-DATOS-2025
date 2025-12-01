unit estadisticas;
{$mode ObjFPC}{$H+}
interface
uses
    Classes, SysUtils, archivos, unit_arbol, usa_arbol, usa_archivo, interfaz_aux;

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
    clrscr;
    DibujarMarco(15, 6, 65, 16, LightBlue);
    TextoCentrado(7, 'SELECCION DE PERIODO', White);
    TextoCentrado(8, 'Ingrese el rango de fechas', LightCyan);
    textcolor(Blue);
    gotoxy(16, 9);
    writeln('-------------------------------------------------');
    textcolor(Yellow);
    gotoxy(20, 11); write('Fecha de inicio (AAAA/MM/DD): ');
    textcolor(White);
    readln(fecha_inicio);
    while not(fecha_valida(fecha_inicio)) do
    begin
        textcolor(LightRed);
        gotoxy(20, 12); write('Fecha invalida. Reintente: ');
        textcolor(White);
        readln(fecha_inicio);
    end;
    textcolor(Yellow);
    gotoxy(20, 13); write('Fecha final (AAAA/MM/DD)  : ');
    textcolor(White);
    readln(fecha_final);
    while not(fecha_valida(fecha_final)) do
    begin
        textcolor(LightRed);
        gotoxy(20, 14); write('Fecha invalida. Reintente: ');
        textcolor(White);
        readln(fecha_final);
    end;
    textcolor(LightGreen);
    TextoCentrado(15, 'Fechas cargadas correctamente', LightGreen);
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
            calcular_evaluaciones_por_discapacidad(arb_ev^.sai, a, arb_leg, contadores, fecha_final, fecha_inicio);
        if (fecha_nodo >= fecha_inicio) and (fecha_nodo <= fecha_final) then
        begin
            legajo_nodo := copy(arb_ev^.info.clave, 12, length(arb_ev^.info.clave)-11);
            Preorden(arb_leg, legajo_nodo, enc, x);
            if enc then
                leer_archivo_1(a, x.pos_arch, r);
                for i := 1 to 5 do
                begin
                    if r.discapacidades[i] = true then
                        contadores[i] := contadores[i] + 1;
                end;
            end;
        end;
        if fecha_nodo <= fecha_final then
            calcular_evaluaciones_por_discapacidad(arb_ev^.sad, a, arb_leg, contadores, fecha_final, fecha_inicio);
    end;

procedure mostrar_evaluaciones_por_discapacidad(var a:t_archivo_alumnos; var arb_ev, arb_leg:t_punt);
var
    contadores: array[1..5] of integer;
    i: integer;
    fecha_inicio: string;
    fecha_final: string;
    hubo_datos: boolean;
begin
    if arb_ev = nil then
    begin
        clrscr;
        DibujarMarco(20, 10, 60, 14, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay evaluaciones registradas', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end
    else
    begin
        hubo_datos := false;
        clrscr;
        cargar_periodo(fecha_inicio, fecha_final);
        for i := 1 to 5 do
            contadores[i] := 0; 
        calcular_evaluaciones_por_discapacidad(arb_ev, a, arb_leg, contadores, fecha_final, fecha_inicio);
        clrscr;
        DibujarMarco(8, 3, 72, 22, LightBlue);
        TextoCentrado(4, 'EVALUACIONES POR DISCAPACIDAD', White);
        textcolor(LightCyan);
        gotoxy(18, 5); write('Periodo: ', fecha_inicio, ' - ', fecha_final);
        textcolor(Blue);
        gotoxy(9, 6);
        writeln('--------------------------------------------------------------');
        textcolor(Yellow);
        gotoxy(12, 8); write('DISCAPACIDAD');
        gotoxy(50, 8); write('EVALUACIONES');
        textcolor(Blue);
        gotoxy(9, 9);
        writeln('--------------------------------------------------------------');
        for i := 1 to 5 do
        begin
            if contadores[i] > 0 then
                hubo_datos := true;
            
            textcolor(LightGray);
            gotoxy(12, 10 + i); write(DISCAPACIDADES[i]);
            textcolor(White);
            gotoxy(54, 10 + i); write(contadores[i]);
        end;
        textcolor(Blue);
        gotoxy(9, 16);
        writeln('--------------------------------------------------------------');
        if not(hubo_datos) then
        begin
            textcolor(LightRed);
            TextoCentrado(18, 'No se registraron evaluaciones en el periodo', LightRed);
        end;
        textcolor(White);
        gotoxy(22, 20); write('Presione cualquier tecla para continuar...');
        readkey;
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
            calcular_grados(arb_ev^.sai, e, puntos_dificultad, fecha_inicio, fecha_final);
        if (fecha_nodo >= fecha_inicio) and (fecha_nodo <= fecha_final) then
        begin
            leer_archivo_2(e, arb_ev^.info.pos_arch, r);
            for i := 1 to 5 do
            begin
                puntos_dificultad[i] := puntos_dificultad[i] + r.valoracion[i];
            end;
        end;
        if fecha_nodo <= fecha_final then
            calcular_grados(arb_ev^.sad, e, puntos_dificultad, fecha_inicio, fecha_final);
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
    DibujarMarco(8, 3, 72, 20, LightBlue);
    TextoCentrado(4, 'DISCAPACIDADES CON MAYOR DIFICULTAD', White);
    textcolor(LightCyan);
    gotoxy(18, 5); write('Periodo: ', fecha_inicio, ' - ', fecha_final);
    textcolor(Blue);
    gotoxy(9, 6);
    writeln('--------------------------------------------------------------');
    textcolor(Yellow);
    gotoxy(12, 8); write('RANKING');
    gotoxy(25, 8); write('DISCAPACIDAD');
    gotoxy(50, 8); write('GRADO DIFICULTAD');
    textcolor(Blue);
    gotoxy(9, 9);
    writeln('--------------------------------------------------------------');
    for i := 1 to 5 do
    begin
        case i of
            1: textcolor(LightRed);     
            2: textcolor(Yellow);       
            3: textcolor(LightCyan);    
            else textcolor(LightGray);  
        end;
        
        gotoxy(15, 10 + i); write(i, '°');
        gotoxy(25, 10 + i); write(vec_nombres[i]);
        textcolor(White);
        gotoxy(55, 10 + i); write(vec_grados[i]);
    end;
    textcolor(Blue);
    gotoxy(9, 16);
    writeln('--------------------------------------------------------------');
    textcolor(White);
    gotoxy(22, 18); write('Presione cualquier tecla para continuar...');
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
        contadores[i] := 0;
    
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
        DibujarMarco(5, 3, 75, 21, LightBlue);
        TextoCentrado(4, 'ALUMNOS ACTIVOS POR DISCAPACIDAD', White);
        textcolor(LightCyan);
        gotoxy(28, 5); write('Total de Alumnos Activos: ');
        textcolor(LightGreen);
        write(activos);
        textcolor(Blue);
        gotoxy(6, 6);
        writeln('--------------------------------------------------------------------');
        textcolor(Yellow);
        gotoxy(10, 8); write('DISCAPACIDAD');
        gotoxy(48, 8); write('CANTIDAD');
        gotoxy(60, 8); write('PORCENTAJE'); 
        textcolor(Blue);
        gotoxy(6, 9);
        writeln('--------------------------------------------------------------------'); 
        for i := 1 to 5 do
        begin
            textcolor(LightGray);
            gotoxy(10, 10 + i); write(DISCAPACIDADES[i]);
            
            textcolor(White);
            gotoxy(51, 10 + i); write(contadores[i]);
            
            porcentaje := (contadores[i] / activos) * 100;
            
            if porcentaje >= 50 then
                textcolor(LightRed)
            else if porcentaje >= 25 then
                textcolor(Yellow)
            else
                textcolor(LightGreen);
                
            gotoxy(62, 10 + i); write(porcentaje:0:2, '%');
        end; 
        textcolor(Blue);
        gotoxy(6, 16);
        writeln('--------------------------------------------------------------------');  
        textcolor(White);
        gotoxy(22, 19); write('Presione cualquier tecla para continuar...');
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay alumnos activos registrados', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
    end;
    readkey;
end;
end.  