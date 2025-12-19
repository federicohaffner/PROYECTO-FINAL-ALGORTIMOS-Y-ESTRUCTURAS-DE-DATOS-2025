unit Interfaz;
{$mode ObjFPC}{$H+}
interface
uses
   Classes, SysUtils, Crt, Archivos, Unit_arbol, Alumnos, Evaluaciones, Validaciones, Listados, Estadisticas, Usa_arbol, Usa_archivo, Interfaz_aux, Inicializacion;

procedure menu_principal;
procedure menu_alumno( var a:t_archivo_alumnos; var arb_leg:t_punt; var arb_ayn:t_punt );
procedure menu_seguimiento(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt);
procedure menu_listados( var a:t_archivo_alumnos; var arb_ayn:t_punt; var arb_ev, arb_leg:t_punt; var e:t_archivo_evaluaciones);
procedure menu_estadisticas( var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_ev, arb_leg:t_punt);

implementation

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
      DibujarMarco(15, 4, 65, 22, green);
      TextoCentrado(6, 'SISTEMA DE GESTION EDUCATIVA', White);
      TextoCentrado(7, 'Seguimiento de Aprendizaje', green);
      textcolor(green);
      gotoxy(16, 9);
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Gestion de Alumnos');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Seguimiento y Evaluaciones');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Generar Listados');
      gotoxy(25, 17); textcolor(White); write('4.'); textcolor(LightGray); write('  Estadisticas Generales');
      gotoxy(25, 19); textcolor(white); write('0.'); textcolor(LightGray); write('  Salir del Sistema');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
      readln(opcion);
      case opcion of
        1:menu_alumno(a, arb_leg, arb_ayn);
        2:menu_seguimiento(e, a, arb_ev, arb_leg, arb_ayn);
        3:menu_listados(a, arb_ayn, arb_ev, arb_leg,e);
        4:menu_estadisticas(a, e, arb_ev, arb_leg);
      end;
   until opcion=0;
   TextoCentrado(26,'Gracias por usar el sistema',green);
   TextoCentrado(27,'Hasta luego',green);
   readkey;
   cerrar_archivo_1(a);
   cerrar_archivo_2(e);
end;

procedure menu_alumno(var a: t_archivo_alumnos; var arb_leg: t_punt; var arb_ayn: t_punt);
var
   legajo: string;
   opcion: byte;
begin
   repeat
      clrscr;
      DibujarMarco(15, 6, 65, 13, green);
      TextoCentrado(7, 'GESTION DE ALUMNOS', White);
      TextoCentrado(8, 'Buscar alumno por legajo', green);
      textcolor(green);
      gotoxy(16, 9); writeln('-------------------------------------------------');
      textcolor(green);
      gotoxy(35, 15); write(' (0 Salir) ');
      gotoxy(20, 11); write('Legajo del alumno: ');
      textcolor(White);
      readln(legajo);
      if legajo <> '0' then
      begin
         while not(legajo_valido(legajo)) do
         begin
            clrscr;
            DibujarMarco(15, 6, 55, 12, Red);
            textcolor(Red);
            gotoxy(27, 7); write('Legajo invalido.');
            gotoxy(16, 8); writeln('---------------------------------------');
            gotoxy(20, 10); write('Reintente: ');
            textcolor(White);
            gotoxy(16, 9); write(': ');
            readln(legajo);
         end;
         if Resolver_Estado_Alumno(legajo, a, arb_leg, arb_ayn) then
         begin
            repeat
               clrscr;
               consulta_alumnos(a, arb_leg, arb_ayn, legajo);
               DibujarMarco(75, 3, 107, 15, green);
               gotoxy(83, 4); textcolor(white); writeln('OPCIONES DE ALUMNO');
               textcolor(green); gotoxy(76, 5); writeln('--------------------------------');
               textcolor(White); gotoxy(78, 7); write('1.'); textcolor(LightGray); write('  Dar de baja alumno');
               textcolor(White); gotoxy(78, 9); write('2.'); textcolor(LightGray); write('  Modificar alumno');
               textcolor(white); gotoxy(78, 11); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
               textcolor(green); gotoxy(78, 13); write('Opcion: ');
               textcolor(White); readln(opcion);
               case opcion of
                  1: begin
                        clrscr;
                        baja_alumnos(a, arb_leg, arb_ayn, legajo);
                     end;
                  2: begin
                        clrscr;
                        modificar_alumno(a, arb_leg, arb_ayn, legajo);
                     end;
                  0: legajo := '0';
               end;
            until opcion = 0;
         end;
      end;
   until legajo = '0';
end;


procedure menu_seguimiento(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt);
var
   opcion: byte;
   fecha: string;
   legajo: string;
begin
   legajo := ingresar_legajo;
   if legajo <> '0' then
   begin
      if Resolver_Estado_Alumno(legajo, a, arb_leg, arb_ayn) then
      begin
         repeat
            clrscr;
            DibujarMarco(15, 4, 65, 22, green);
            TextoCentrado(6, 'SEGUIMIENTO Y EVALUACIONES', White);
            TextoCentrado(7, 'Gestion de Evaluaciones Academicas', green);
            textcolor(green); gotoxy(16, 9); writeln('-------------------------------------------------');
            textcolor(LightGreen); gotoxy(32, 8); write('Legajo: ', legajo);
            textcolor(White);
            gotoxy(25, 11); textcolor(White); write('1.'); textcolor(LightGray); write('  Alta de una evaluacion');
            gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Modificacion de una evaluacion');
            gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Consulta de una evaluacion');
            gotoxy(25, 17); textcolor(White); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
            TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
            readln(opcion);
            case opcion of
               1: begin
                    fecha := FormatDateTime('yyyy/mm/dd', Date);
                    alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
                  end;
               2: begin
                    clrscr;
                    fecha := ingresar_fecha;
                    if (fecha <> '0') then
                       modificar_eval(e, a, arb_ev, arb_leg, arb_ayn, legajo, fecha);
                  end;
               3: begin
                    clrscr;
                    fecha := ingresar_fecha;
                    if (fecha <> '0') then
                       consulta_ev(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
                  end;
            end;
         until opcion = 0;
      end;
   end;
end;

procedure menu_listados(var a: t_archivo_alumnos; var arb_ayn: t_punt; var arb_ev, arb_leg: t_punt;var e:t_archivo_evaluaciones);
var
   opcion: byte;
   dif: byte;
begin
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, green);
      TextoCentrado(6, 'GENERACION DE LISTADOS', White);
      TextoCentrado(7, 'Reportes y Consultas del Sistema', green);
      textcolor(green);
      gotoxy(16, 9);
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(white); write('  Listado de alumnos');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Listado de evaluaciones');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Listado por dificultades');
      gotoxy(25, 17); textcolor(White); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             listado_alumnos(arb_ayn, a);
           end;
        2: begin
             clrscr;
             listado_ev(a, arb_ayn,arb_leg,arb_ev,e);
           end;
        3: begin
             clrscr;
             cargar_dificultad(dif);
             listado_dificultad(arb_ayn, dif, a);
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
      DibujarMarco(15, 4, 70, 22, green);
      gotoxy(33,6);
      Writeln( 'ESTADISTICAS GENERALES');
      gotoxy (28,7);
      writeln ( 'Analisis y Reportes Estadisticos');
      textcolor(green);
      gotoxy(16, 9);
      writeln('------------------------------------------------------');
      textcolor(White);
      gotoxy(18, 11); write('1.'); textcolor(LightGray); write(' Distribucion de evaluaciones por dificultades');
      gotoxy(18, 13); textcolor(White); write('2.'); textcolor(LightGray); write(' dificultades con mayor grado');
      gotoxy(18, 15); textcolor(White); write('3.'); textcolor(LightGray); write(' dificultades con mayor numero de alumnos');
      gotoxy(18, 17); textcolor(White); write('0.'); textcolor(LightGray); write(' Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             mostrar_evaluaciones_por_dificultad(a, arb_ev, arb_leg);
           end;
        2: begin
             clrscr;
             dificultades_mayor_valoracion(e, arb_ev);
           end;
        3: begin
             clrscr;
             alumnos_activos_por_dificultad(a);
           end;
      end;
   until opcion = 0;
end;
end.