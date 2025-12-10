unit Interfaz;
{$mode ObjFPC}{$H+}
interface
uses
   Classes, SysUtils, crt, archivos, unit_arbol, alumnos, evaluaciones, validaciones, listados, estadisticas, usa_arbol, usa_archivo, interfaz_aux;

procedure menu_principal;
procedure menu_alumno( var a:t_archivo_alumnos; var arb_leg:t_punt; var arb_ayn:t_punt );
procedure menu_seguimiento(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt);
procedure menu_listados( var a:t_archivo_alumnos; var arb_ayn:t_punt; var arb_ev:t_punt );
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
        3:menu_listados(a, arb_ayn, arb_ev);
        4:menu_estadisticas(a, e, arb_ev, arb_leg);
      end;
   until opcion=0;
   TextoCentrado(28, 'Gracias por usar el sistema. Hasta luego!', LightGreen);
   readkey;
   cerrar_archivo_1(a);
   cerrar_archivo_2(e);
end;

procedure menu_alumno(var a: t_archivo_alumnos; var arb_leg: t_punt; var arb_ayn: t_punt);
var
   legajo: string;
   opcion: byte;
   seguir_alumno: boolean;
   seguir_validacion: boolean;
   respuesta: char;
   x_check: t_dato_arbol;
   existe_fisico: boolean;
   acceso_concedido: boolean;
begin
   repeat
      clrscr;
      DibujarMarco(15, 6, 65, 18, green);
      TextoCentrado(7, 'GESTION DE ALUMNOS', White);
      TextoCentrado(8, 'Buscar alumno por legajo', green);
      textcolor(green);
      gotoxy(16, 9);
      writeln('-------------------------------------------------');
      textcolor(green);
      gotoxy(20, 11); write('Legajo del alumno ');
      gotoxy(20, 12); write('0 VOLVER: ');
      textcolor(White);
      readln(legajo);
      if legajo <> '0' then
      begin
         seguir_validacion := true;
         while not(legajo_valido(legajo)) and seguir_validacion do
         begin
            textcolor(LightRed);
            gotoxy(20, 13); write('Legajo invalido. Reintente  ');
            gotoxy(20, 14); write('0 VOLVER:  ');
            textcolor(White);
            readln(legajo);
            if legajo = '0' then seguir_validacion := false;
         end;
         if (legajo <> '0') and seguir_validacion then
         begin
            acceso_concedido := false;
            if buscar_legajo(a, arb_leg, arb_ayn, legajo) then
            begin
               acceso_concedido := true;
            end
            else
            begin
               PREORDEN(arb_leg, legajo, existe_fisico, x_check);
               clrscr;
               DibujarMarco(15, 10, 65, 16, green);

               if existe_fisico then
               begin
                   textcolor(LightRed);
                   TextoCentrado(11, 'ALUMNO DE BAJA', green);
                   textcolor(LightGray);
                   TextoCentrado(12, 'El alumno existe pero esta inactivo.', green);
                   textcolor(green);
                   gotoxy(20, 14); write('Desea reactivarlo? (S/N): ');
               end
               else
               begin
                   textcolor(LightRed);
                   TextoCentrado(11, 'ALUMNO NO ENCONTRADO', White);
                   textcolor(LightGray);
                   TextoCentrado(12, 'Legajo: ' + legajo, green);
                   textcolor(green);
                   gotoxy(20, 14); write('Desea dar de alta este alumno? (S/N): ');
               end;
               textcolor(White);
               readln(respuesta);

               if upcase(respuesta) = 'S' then
               begin
                  clrscr;
                  alta_alumnos(a, legajo, arb_leg, arb_ayn);
                  acceso_concedido := true;
               end;
            end;
            if acceso_concedido then
            begin
               seguir_alumno := true;
               while seguir_alumno do
               begin
                  clrscr;
                  DibujarMarco(15, 4, 65, 20, green);
                  TextoCentrado(5, 'OPCIONES DE ALUMNO', White);
                  textcolor(green);
                  gotoxy(28, 6); write('Legajo: ', legajo);
                  textcolor(green);
                  gotoxy(16, 7);
                  writeln('-------------------------------------------------');
                  textcolor(White);
                  gotoxy(25, 10); write('1.'); textcolor(LightGray); write('  Consultar alumno');
                  gotoxy(25, 12); textcolor(White); write('2.'); textcolor(LightGray); write('  Dar de baja alumno');
                  gotoxy(25, 14); textcolor(White); write('3.'); textcolor(LightGray); write('  Modificar alumno');
                  gotoxy(25, 16); textcolor(white); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
                  textcolor(green);
                  gotoxy(25, 18); write('Opcion: ');
                  textcolor(White);
                  readln(opcion);

                  case opcion of
                     1: begin clrscr; consulta_alumnos(a, arb_leg, arb_ayn, legajo); end;
                     2: begin clrscr; baja_alumnos(a, arb_leg, arb_ayn, legajo); end;
                     3: begin clrscr; modificar_alumno(a, arb_leg, arb_ayn, legajo); end;
                     0: begin
                           seguir_alumno := false;
                           legajo := '0';
                        end;
                  end;
               end;
            end;
         end;
      end;
   until legajo = '0';
end;


procedure menu_seguimiento(var e: t_archivo_evaluaciones; var a: t_archivo_alumnos; var arb_ev, arb_leg, arb_ayn: t_punt);
var
   opcion: byte;
   fecha: string;
   legajo: string;
   r: t_dato_evaluaciones;
begin
   repeat
      clrscr;
      DibujarMarco(15, 4, 65, 22, green);
      TextoCentrado(6, 'SEGUIMIENTO Y EVALUACIONES', White);
      TextoCentrado(7, 'Gestion de Evaluaciones Academicas', green);
      textcolor(green);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Alta de una evaluacion');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Modificacion de una evaluacion');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Consulta de una evaluacion'); 
      gotoxy(25, 17); textcolor(White); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
      readln(opcion);
      case opcion of
        1: begin
             clrscr;
             fecha := ingresar_fecha;
             if (fecha <> '0') then
             begin
                  legajo := ingresar_legajo;
                  if (legajo <> '0') then
                     alta_evaluacion(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
           end;
        end;
        2: begin
             clrscr;
             fecha := ingresar_fecha;
             if (fecha <> '0') then
             begin
                  legajo := ingresar_legajo;
                  if (legajo <> '0') then
                     modificar_eval(e, a, arb_ev, arb_leg, arb_ayn, legajo, fecha);
             end;
             end;
        3: begin
             clrscr;
             fecha := ingresar_fecha;
             if (fecha <> '0') then
             begin
                legajo := ingresar_legajo;
                if (legajo <> '0') then
                   consulta_ev(arb_ev, arb_leg, arb_ayn, fecha, legajo, e, a);
             end;
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
      DibujarMarco(15, 4, 65, 22, green);
      TextoCentrado(6, 'GENERACION DE LISTADOS', White);
      TextoCentrado(7, 'Reportes y Consultas del Sistema', green);
      textcolor(green);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(white); write('  Listado de alumnos');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Listado de evaluaciones');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Listado por discapacidades'); 
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
             legajo := ingresar_legajo;
             if legajo <> '0' then
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
      DibujarMarco(15, 4, 65, 22, green);
      TextoCentrado(6, 'ESTADISTICAS GENERALES', White);
      TextoCentrado(7, 'Analisis y Reportes Estadisticos', green);
      textcolor(green);
      gotoxy(16, 9); 
      writeln('-------------------------------------------------');
      textcolor(White);
      gotoxy(25, 11); write('1.'); textcolor(LightGray); write('  Distribucion de evaluaciones por discapacidades');
      gotoxy(25, 13); textcolor(White); write('2.'); textcolor(LightGray); write('  Discapacidades con mayor grado de dificultad');
      gotoxy(25, 15); textcolor(White); write('3.'); textcolor(LightGray); write('  Discapacidades con mayor numero de alumnos'); 
      gotoxy(25, 17); textcolor(White); write('0.'); textcolor(LightGray); write('  Volver al menu principal');
      TextoCentrado(24, 'Ingrese el numero de opcion: ', white);
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
end;
end.      