unit interfaz;
{$mode ObjFPC}{$H+}
interface
uses
   Classes, SysUtils, crt, archivos, unit_arbol, alumnos, evaluaciones, validaciones, listados, estadisticas;

procedure menu_principal;
procedure menu_alumno( var a:t_archivo_alumnos; var arb_leg:t_punt; var arb_ayn:t_punt );
procedure menu_seguimiento( var e:t_archivo_evaluaciones; var arb_ev, arb_leg:t_punt);
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
      textcolor(white);
      gotoxy(40,10);
      write('*Bienvenido al sistema de ');
      textcolor(blue);
      writeln('seguimiento de aprendizaje*');
      textcolor(blue);
      gotoxy(52,12);
      write('1- ');
      textcolor(white);
      writeln('Menu Alumno');
      gotoxy(52,14);
      textcolor(blue);
      write('2- ');
      textcolor(white);
      writeln('Menu Seguimiento');
      gotoxy(52,16);
      textcolor(blue);
      write('3- ');
      textcolor(white);
      writeln('Menu Listados');
      gotoxy(52,18);
      textcolor(blue);
      write('4- ');
      textcolor(white);
      writeln('Menu Estadisticas');
      gotoxy(52,20);
      textcolor(blue);
      write('0- ');
      textcolor(white);
      writeln('Salir del programa');
      gotoxy(52,22);
      textcolor(blue);
      write('Respuesta: ');
      textcolor(white);
      readln(opcion);
      validar_opcion(opcion);
      case opcion of
        1:menu_alumno();
        2:menu_seguimiento();
        3:menu_listados();
        4:menu_estadisticas();
      end;
   until opcion=0;
   cerrar_archivo(arch_alumnos);
   cerrar_archivo(arch_evaluaciones);
end;


procedure menu_alumno( var a:t_archivo_alumnos; var arb_leg:t_punt; var arb_ayn:t_punt );
var
   legajo: string;
   baja: boolean;
   opcion: byte;
   pos:byte;
   fecha:string;
begin
   while opcion <> 0 do
   begin
      clrscr;
      textcolor(white);
      gotoxy(40,10);
      write('*Menu ');
      textcolor(blue);
      writeln('Alumnos*');
      textcolor(white);
      gotoxy(30,12);
      write('Ingrese un legajo (0 para volver): ');
      readln(legajo);
      if  legajo = 0 then
         opcion := 0;
      while not(legajo_valido(legajo)) do
      begin
         clrscr;
         gotoxy(30,12);
         write('Ingrese un legajo valido (0 para volver): ');
         readln(legajo);
         if  legajo = 0 then
            opcion := 0;
      end;
      if buscar_legajo(a, legajo, arb_leg, arb_ayn) then
      begin
         gotoxy(30,14);
         writeln('1- Consultar alumno');
         gotoxy(30,15);
         writeln('2- Dar de baja alumno');
         gotoxy(30,16);
         writeln('3- Modificar alumno');
         gotoxy(30,18);
         write('0- Volver al menu anterior');
         readln(opcion);
         case opcion of
            1: begin 
                  clrscr; 
                  consulta_alumnos(a, arb_leg, arb_ayn, legajo);
               end;
            2: begin 
                  clrscr; 
                  baja_alumnos(a, arb_leg, arb_ayn, legajo); 
               end;
            3: begin 
                  clrscr; 
                  modificar_alumnos(a, arb_leg, arb_ayn, legajo);
               end;
         end;
      end
      else
      begin
         alta_alumnos(a, legajo, arb_leg, arb_ayn);
      end;
   end;
end;

procedure menu_seguimiento( var e:t_archivo_evaluaciones; var arb_ev, arb_leg:t_punt);
var
   opcion: byte;
   fecha: string;
   legajo: string;
begin
     repeat
      clrscr;
      textcolor(white);
      gotoxy(40,10);
      write('*Menu ');
      textcolor(blue);
      writeln(' Seguimiento*');
      textcolor(blue);
      gotoxy(52,12);
      write('1- ');
      textcolor(white);
      writeln('Alta de una evaluacion');
      gotoxy(52,14);
      textcolor(blue);
      write('2- ');
      textcolor(white);
      writeln('Modificacion de una evaluacion');
      gotoxy(52,16);
      textcolor(blue);
      write('3- ');
      textcolor(white);
      writeln('Consulta de una evaluacion');
      gotoxy(52,18);
      textcolor(blue);
      write('0- ');
      textcolor(white);
      writeln('Volver al menu principal');
      gotoxy(52,20);
      textcolor(blue);
      write('Respuesta: ');
      textcolor(white);
      readln(opcion);
      case opcion of
        1:begin
               clrscr;
               cargar_fecha(r);
               cargar_legajo(legajo);
               alta_evaluacion(arb_ev, arb_leg, fecha, legajo, e );
          end;
        2:begin
               clrscr;
               cargar_fecha(r);
               cargar_legajo(legajo);
               modificacion_evaluacion(e, arb_ev, arb_leg, legajo, fecha);
          end;
        3:begin
               clrscr;
               cargar_fecha(r);
               cargar_legajo(legajo);
               consulta_evaluacion(arb_ev, arb_leg, fecha, legajo, e);
          end;
      end;
   until opcion=0;
end;

procedure menu_listados( var a:t_archivo_alumnos; var arb_ayn:t_punt; var arb_ev:t_punt );
var
   opcion: byte;
   legajo: string;
   disc: byte;
begin
     repeat
      clrscr;
      textcolor(white);
      gotoxy(40,10);
      write('*Menu ');
      textcolor(blue);
      writeln(' Listados*');
      textcolor(blue);
      gotoxy(52,12);
      write('1- ');
      textcolor(white);
      writeln('Listado de alumnos');
      gotoxy(52,14);
      textcolor(blue);
      write('2- ');
      textcolor(white);
      writeln('Listado de evaluaciones');
      gotoxy(52,16);
      textcolor(blue);
      write('3- ');
      textcolor(white);
      writeln('Listado por discapaciad');
      gotoxy(52,18);
      textcolor(blue);
      write('0- ');
      textcolor(white);
      writeln('Volver al menu principal');
      gotoxy(52,20);
      textcolor(blue);
      write('Respuesta: ');
      textcolor(white);
      readln(opcion);
      case opcion of
        1:begin
               clrscr;
               listado_alumnos(arb_ayn);
          end;
        2:begin
               clrscr;
               cargar_legajo(legajo);
               listado_ev(arb_ev, legajo);
          end;
        3:begin
               clrscr;
               cargar_discapacidad(disc);
               listado_discapacidad(arb_ayn, disc, a);
          end;
      end;
   until opcion=0;
end;

procedure menu_estadisticas(var a:t_archivo_alumnos; var e:t_archivo_evaluaciones; var arb_ev, arb_leg:t_punt);
var
   opcion: byte;
begin
     repeat
      clrscr;
      textcolor(white);
      gotoxy(40,10);
      write('*Menu ');
      textcolor(blue);
      writeln(' Estadisticas*');
      textcolor(blue);
      gotoxy(52,12);
      write('1- ');
      textcolor(white);
      writeln('Distribucion de evaluaciones por discapaciad');
      gotoxy(52,14);
      textcolor(blue);
      write('2- ');
      textcolor(white);
      writeln('Discapaciades con mayor grado de dificultad');
      gotoxy(52,16);
      textcolor(blue);
      write('3- ');
      textcolor(white);
      writeln('Discapaciades con mayor numero de alumnos');
      gotoxy(52,18);
      textcolor(blue);
      write('0- ');
      textcolor(white);
      writeln('Volver al menu principal');
      gotoxy(52,20);
      textcolor(blue);
      write('Respuesta: ');
      textcolor(white);
      readln(opcion);
      case opcion of
        1:begin
               clrscr;
               mostrar_evaluaciones_por_discapacidad(a, arb_ev, arb_leg);
          end;
        2:begin
               clrscr;
               discapacidades_mayor_dificultad(e, arb_ev);
          end;
        3:begin
               clrscr;
               alumno_activos_por_dificultad(a);
          end;
      end;
   until opcion=0;
   writeln('Gracias por usar el sistema. ¡Hasta luego!');
end;
end.