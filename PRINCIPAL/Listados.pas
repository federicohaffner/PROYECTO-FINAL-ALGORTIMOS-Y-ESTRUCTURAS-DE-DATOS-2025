unit listados;
{$mode ObjFPC}{$H+}
interface
    
uses
    crt, SysUtils, Classes, unit_arbol, archivos, validaciones, usa_arbol, interfaz_aux;

procedure listado_alumnos(arb_ayn:t_punt);
procedure listado_ev (arb_ev:t_punt; legajo:string);
procedure listado_discapacidad (arb_ayn:t_punt; disc:byte; var arch:t_archivo_alumnos  );
    
implementation
    
procedure listado_alumnos(arb_ayn:t_punt);
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightBlue);
        TextoCentrado(3, 'LISTADO COMPLETO DE ALUMNOS', White);
        TextoCentrado(4, 'Ordenado alfabeticamente', LightCyan);
        textcolor(Blue);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');
        textcolor(Yellow);
        gotoxy(10, 6); write('APELLIDO Y NOMBRE');
        gotoxy(50, 6); write('LEGAJO');
        textcolor(Blue);
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGray);
        gotoxy(10, 8);
        inorden(arb_ayn);
        textcolor(Blue);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay alumnos cargados en el sistema', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end;
end;

procedure listado_ev (arb_ev:t_punt; legajo:string);
begin
    clrscr;
    if arb_ev <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightBlue);
        TextoCentrado(3, 'LISTADO DE EVALUACIONES', White);
        textcolor(LightCyan);
        gotoxy(28, 4); write('Legajo del alumno: ', legajo);
        textcolor(Blue);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');  
        textcolor(Yellow);
        gotoxy(10, 6); write('FECHA');
        gotoxy(30, 6); write('OBSERVACIONES');
        gotoxy(60, 6); write('VALORACION');
        textcolor(Blue);
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGray);
        gotoxy(10, 8);
        INORDEN_leg(arb_ev, legajo);
        textcolor(Blue);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay evaluaciones en el sistema', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end;
end;

procedure listado_discapacidad (arb_ayn:t_punt; disc:byte; var arch:t_archivo_alumnos);
begin
    clrscr;
    if arb_ayn <> nil then
    begin
        DibujarMarco(5, 2, 75, 24, LightBlue);
        TextoCentrado(3, 'LISTADO POR DISCAPACIDAD', White);
        textcolor(LightCyan);
        gotoxy(25, 4); write('Discapacidad: ', DISCAPACIDADES[disc]);
        textcolor(Blue);
        gotoxy(6, 5);
        writeln('--------------------------------------------------------------------');
        textcolor(Yellow);
        gotoxy(10, 6); write('APELLIDO Y NOMBRE');
        gotoxy(45, 6); write('LEGAJO');
        gotoxy(60, 6); write('ESTADO');
        textcolor(Blue);
        gotoxy(6, 7);
        writeln('--------------------------------------------------------------------');
        textcolor(LightGray);
        gotoxy(10, 8);
        inorden_disc(arb_ayn, disc, arch);
        textcolor(Blue);
        gotoxy(6, 23);
        writeln('--------------------------------------------------------------------');
        textcolor(White);
        gotoxy(20, 23); write('Presione cualquier tecla para continuar...');
        readkey;
    end
    else
    begin
        DibujarMarco(20, 10, 60, 14, LightBlue);
        textcolor(LightRed);
        TextoCentrado(11, 'SIN DATOS', White);
        textcolor(LightGray);
        TextoCentrado(12, 'No hay alumnos cargados en el sistema', LightGray);
        textcolor(White);
        gotoxy(25, 13); write('Presione una tecla...');
        readkey;
    end;
end;
end;

end.  