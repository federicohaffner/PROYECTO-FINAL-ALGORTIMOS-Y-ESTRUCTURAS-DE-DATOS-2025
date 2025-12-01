unit Interfaz_paises;

interface

uses
  crt, sysutils, Declaracion_paises, Datos_paises, Respuestas_paises;

procedure menu_principal;
procedure Menu_inicial;
procedure Menu_final;

implementation

procedure Menu_inicial;
begin
  clrscr;
  textcolor(11);
  gotoxy(33, WhereY);
  writeln('|===========================================================|');
  gotoxy(33, WhereY);
  writeln('|------------------------ CHATTERBOT -----------------------|');
  gotoxy(33, WhereY);
  writeln('|===========================================================|');
  textcolor(11);
  gotoxy(57, WhereY);
  writeln('HOLA BIENVENIDO');
  gotoxy(38, WhereY);
  writeln('SOY TU ASISTENTE VIRTUAL ESPECIALIZADO EN GEOGRAFIA');
  textcolor(white);
  writeln;
  gotoxy(36, WhereY);
  writeln('Ingrese su consulta');
  writeln;
  gotoxy(36, WhereY);
  writeln('[Escribe "ayuda" para comandos | "salir" para terminar]');
  writeln;
  textcolor(white);
end;

procedure Menu_final;
begin
  textcolor(11);
  writeln;
  gotoxy(33, whereY);
  writeln('|===========================================================|');
  gotoxy(33, whereY);
  writeln('|---------- Gracias por usar nuestro Chatterbot ------------|');
  gotoxy(33, whereY);
  writeln('|---------------------- Hasta pronto -----------------------|');
  gotoxy(33, whereY);
  writeln('|===========================================================|');
  textcolor(white);
  readkey;
end;

procedure menu_principal;
var
  entrada: string;
  salir: boolean;
  vector_paises: t_vector_pais;
  cantidad_paises: integer;
begin
  Inicializar(vector_paises, cantidad_paises);
  CargarBaseDeDatos(vector_paises, cantidad_paises);

  Menu_inicial;
  salir := false;

  repeat
    textcolor(11);
    gotoxy(33, whereY);
    write('User: ');
    textcolor(white);
    readln(entrada);

    if lowercase(entrada) = 'salir' then
      salir := true
    else if entrada <> '' then
    begin
      textcolor(13);
      gotoxy(33, whereY);
      write('GeoBot: ');
      textcolor(white);
      ProcesarYResponder(entrada, vector_paises, cantidad_paises);
      writeln;
    end;

  until salir;

  Menu_final;
end;

end.   