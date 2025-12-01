unit interfaz;
{$mode ObjFPC}{$H+}
interface
uses
   Classes, SysUtils, crt, archivos, unit_arbol, alumnos, evaluaciones, validaciones, listados, estadisticas, usa_arbol, usa_archivo, interfaz_aux;

procedure menu_principal;
procedure menu_alumno( var a:t_archivo_alumnos; var arb_leg:t_punt; var arb_ayn:t_punt );
procedure menu_seguimiento( var e:t_archivo_evaluaciones; var arb_ev, arb_leg, arb_ayn:t_punt);
procedure menu_listados( var a:t_archivo_alumnos; var arb_ayn:t_punt; var arb_ev:t_punt );
procedure menu_estadisticas( var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_ev, arb_leg:t_punt);
procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
procedure TextoCentrado(y: integer; texto: string; color: byte);

implementation

procedure DibujarMarco(x1, y1, x2, y2: integer; color: byte);
var
  i: integer;
begin
  textcolor(color);
  gotoxy(x1, y1); write(#201); { ╔ }
  gotoxy(x2, y1); write(#187); { ╗ }
  gotoxy(x1, y2); write(#200); { ╚ }
  gotoxy(x2, y2); write(#188); { ╝ }
  for i := x1 + 1 to x2 - 1 do
  begin
    gotoxy(i, y1); write(#205); { ═ }
    gotoxy(i, y2); write(#205); { ═ }
  end;
  for i := y1 + 1 to y2 - 1 do
  begin
    gotoxy(x1, i); write(#186); { ║ }
    gotoxy(x2, i); write(#186); { ║ }
  end;
end;

procedure TextoCentrado(y: integer; texto: string; color: byte);
var
  x: integer;
begin
  x := (80 - length(texto)) div 2; 
  textcolor(color);
  gotoxy(x, y);
  write(texto);
end;

procedure menu_principal;
var
   opcion: byte;
   a: t_archivo_alumnos;
   e: t_archivo_evaluaciones;
   arb_leg: t_punt;
   arb_ayn: t_punt;
   arb_ev: t_punt;
begin
   arbol_en_memoria(a, e, arb_leg, arb_ayn, arb_ev);
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, LightBlue);
      TextoCentrado(6, 'SISTEMA DE GESTION EDUCATIVA', White);
      TextoCentrado(7, 'Seguimiento de Aprendizaje', LightCyan);
      textcolor(Blue);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Gestion de Alumnos');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Seguimiento y Evaluaciones');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Generar Listados'); 
      gotoxy(25, 17); textcolor(White); write('4.'); textcolor(LightGray); write('  Estadisticas Generales');
      gotoxy(25, 19); textcolor(LightRed); write('0.'); textcolor(LightGray); write('  Salir del Sistema');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', Yellow);
      readln(opcion);
      case opcion of
        1:menu_alumno(a, arb_leg, arb_ayn);
        2:menu_seguimiento(e, arb_ev, arb_leg, arb_ayn);
        3:menu_listados(a, arb_ayn, arb_ev);
        4:menu_estadisticas(a, e, arb_ev, arb_leg);
      end;
   until opcion=0;
   cerrar_archivo_1(a);
   cerrar_archivo_2(e);
end;

procedure menu_seguimiento(var e: t_archivo_evaluaciones; var arb_ev, arb_leg, arb_ayn: t_punt);
var
   opcion: byte;
   fecha: string;
   legajo: string;
   r: t_dato_evaluaciones;
begin
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, LightBlue);
      TextoCentrado(6, 'SEGUIMIENTO Y EVALUACIONES', White);
      TextoCentrado(7, 'Gestion de Evaluaciones Academicas', LightCyan);
      textcolor(Blue);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Alta de una evaluacion');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Modificacion de una evaluacion');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Consulta de una evaluacion'); 
      gotoxy(25, 17); textcolor(LightRed); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', Yellow);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             fecha := ingresar_fecha;
             legajo := ingresar_legajo;
             alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e);
           end;
        2: begin
             clrscr;
             fecha := ingresar_fecha;
             legajo := ingresar_legajo;
             modificar_eval(e, arb_ev, arb_leg, arb_ayn, legajo, fecha);
           end;
        3: begin
             clrscr;
             fecha := ingresar_fecha;
             legajo := ingresar_legajo;
             consulta_ev(arb_ev, arb_leg, arb_ayn, fecha, legajo, e);
           end;
      end;
   until opcion = 0;
end;

procedure menu_listados(var a: t_archivo_alumnos; var arb_ayn: t_punt; var arb_ev: t_punt);
var
   opcion: byte;
   legajo: string;
   disc: byte;
begin
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, LightBlue);
      TextoCentrado(6, 'GENERACION DE LISTADOS', White);
      TextoCentrado(7, 'Reportes y Consultas del Sistema', LightCyan);
      textcolor(Blue);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Listado de alumnos');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Listado de evaluaciones');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Listado por discapacidades'); 
      gotoxy(25, 17); textcolor(LightRed); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', Yellow);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             listado_alumnos(arb_ayn);
           end;
        2: begin
             clrscr;
             legajo := ingresar_legajo;
             listado_ev(arb_ev, legajo);
           end;
        3: begin
             clrscr;
             cargar_discapacidad(disc);
             listado_discapacidad(arb_ayn, disc, a);
           end;
      end;
   until opcion = 0;
end;

procedure menu_estadisticas(var a: t_archivo_alumnos; var e: t_archivo_evaluaciones; var arb_ev, arb_leg: t_punt);
var
   opcion: byte;
begin
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, LightBlue);
      TextoCentrado(6, 'ESTADISTICAS GENERALES', White);
      TextoCentrado(7, 'Analisis y Reportes Estadisticos', LightCyan);
      textcolor(Blue);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Distribucion de evaluaciones por discapacidades');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Discapacidades con mayor grado de dificultad');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Discapacidades con mayor numero de alumnos'); 
      gotoxy(25, 17); textcolor(LightRed); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', Yellow);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             mostrar_evaluaciones_por_discapacidad(a, arb_ev, arb_leg);
           end;
        2: begin
             clrscr;
             discapacidades_mayor_dificultad(e, arb_ev);
           end;
        3: begin
             clrscr;
             alumno_activos_por_dificultad(a);
           end;
      end;
   until opcion = 0;
   writeln('Gracias por usar el sistema. ¡Hasta luego!');
end;
end.