program ChatterbotModular;

uses
  crt, sysutils,
  UnitTiposPaises,
  UnitArchivosPaises,
  UnitBusquedasPaises,
  UnitTiposProcesamiento,
  UnitAnalisisLenguaje,
  UnitGeneradorRespuestas,
  UnitUtilidades;

var
  entrada: string;
  salir: boolean;

procedure MostrarBienvenida;
begin
  clrscr;
  textcolor(yellow);
  writeln('=========================================================');
  writeln('     CHATTERBOT: EXPERTO EN PAISES DE AMERICA');
  writeln('=========================================================');
  textcolor(white);
  writeln;
  writeln('¡Hola! Soy tu asistente virtual especializado en los');
  writeln('paises del continente americano.');
  writeln;
  writeln('Puedes preguntarme sobre:');
  writeln('  - Capitales de los paises');
  writeln('  - Ubicacion geografica (latitud/longitud)');
  writeln('  - Informacion general de cualquier pais');
  writeln('  - Comparaciones entre paises');
  writeln('  - Listados por region');
  writeln;
  writeln('Escribe "salir" o "adios" para terminar la conversacion');
  writeln;
  textcolor(lightgray);
  writeln('Ejemplos de preguntas:');
  writeln('  "¿Cual es la capital de Argentina?"');
  writeln('  "Dime algo sobre Brasil"');
  writeln('  "¿Donde queda Peru?"');
  writeln('  "Muestrame los paises de Sudamerica"');
  writeln;
  textcolor(white);
end;

procedure MostrarDespedida;
begin
  textcolor(yellow);
  writeln;
  writeln('=========================================================');
  writeln('  ¡Gracias por usar el Chatterbot de Paises de America!');
  writeln('            ¡Hasta pronto! Vuelve cuando quieras');
  writeln('=========================================================');
  textcolor(white);
  readkey;
end;

begin
  // Inicializar el sistema
  InicializarSistema;
  CargarBaseDeDatos;

  MostrarBienvenida;
  salir := false;

  repeat
    textcolor(cyan);
    write('Tu: ');
    textcolor(white);
    readln(entrada);

    if (lowercase(entrada) = 'salir') or
       (lowercase(entrada) = 'adios') or
       (lowercase(entrada) = 'chau') then
      salir := true
    else if entrada <> '' then
    begin
      textcolor(green);
      write('Bot: ');
      textcolor(white);
      ProcesarYResponder(entrada);
      writeln;
    end;

  until salir;

  MostrarDespedida;
  CerrarSistema;
end.
