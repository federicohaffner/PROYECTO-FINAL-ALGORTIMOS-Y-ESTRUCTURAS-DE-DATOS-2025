unit Usa_archivo;
{$mode ObjFPC}{$H+}

interface
uses
    SysUtils, archivos, Unit_arbol, Usa_arbol;

function archivo_vacio_1 (var archivo_1:t_archivo_alumnos): boolean;
function archivo_vacio_2 (var archivo_2:t_archivo_evaluaciones): boolean;
procedure crear_abrir_1 (var archivo_1:t_archivo_alumnos);
procedure crear_abrir_2 (var archivo_2:t_archivo_evaluaciones);
procedure cerrar_archivo_1 (var archivo_1:t_archivo_alumnos);
procedure cerrar_archivo_2 (var archivo_2:t_archivo_evaluaciones);
procedure leer_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
procedure leer_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
procedure escribir_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
procedure escribir_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);

implementation

function archivo_vacio_1 (var archivo_1:t_archivo_alumnos): boolean;
begin
     archivo_vacio_1 := filesize(archivo_1) = 0;
end;

function archivo_vacio_2 (var archivo_2:t_archivo_evaluaciones): boolean;
begin
     archivo_vacio_2 := filesize(archivo_2) = 0;
end;

procedure crear_abrir_1 (var archivo_1:t_archivo_alumnos);
begin
     assign(archivo_1, ruta_1);
     {$I-} reset(archivo_1); {$I+}
     if IOResult <> 0 then rewrite(archivo_1);
end;

procedure crear_abrir_2 (var archivo_2:t_archivo_evaluaciones);
begin
     assign(archivo_2, ruta_2);
     {$I-} reset(archivo_2); {$I+}
     if IOResult <> 0 then rewrite(archivo_2);
end;

procedure cerrar_archivo_1 (var archivo_1:t_archivo_alumnos);
begin
     close(archivo_1);
end;

procedure cerrar_archivo_2 (var archivo_2:t_archivo_evaluaciones);
begin
     close(archivo_2);
end;

procedure leer_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
begin
     seek(archivo_1, pos);
     read(archivo_1, x);
end;

procedure leer_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
begin
     seek(archivo_2, pos);
     read(archivo_2, x);
end;

procedure escribir_archivo_1 (var archivo_1:t_archivo_alumnos; pos:integer; var x:t_dato_alumnos);
begin
     seek(archivo_1, pos);
     write(archivo_1, x);
end;

procedure escribir_archivo_2 (var archivo_2:t_archivo_evaluaciones; pos:integer; var x:t_dato_evaluaciones);
begin
     seek(archivo_2, pos);
     write(archivo_2, x);
end;
end.