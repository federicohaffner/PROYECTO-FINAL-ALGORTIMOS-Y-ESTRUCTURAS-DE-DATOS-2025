unit Validaciones;
{$mode ObjFPC}{$H+}

interface
uses
   SysUtils, Classes;
function legajo_valido(legajo:string):boolean;
function escadena(ayn: string): boolean;
function fecha_valida(fecha:string):boolean; {AAAA/MM/DD}
function valoracion_valida(valoracion:byte):boolean;
function tiene_formato_fecha(f: string): boolean;
function nombre_valido(nombre: string): boolean;

implementation

function legajo_valido(legajo:string):boolean;
var
   i:byte;
   esValido:boolean;
begin
   esValido := True;
   i := 1;
   if Length(legajo) <> 8 then
      esValido := False
   else
   begin
      legajo_valido := false;
      while (i <= length(legajo)) and esValido do
      begin
         if not (legajo[i] in ['0'..'9']) then
            esValido := false;
         inc(i);
      end;
      legajo_valido := esValido;
   end;
end;

function escadena(ayn: string): boolean;
var
   i: byte;
   esValido: boolean;
begin
   esValido := true;
   i := 1;
   escadena := false;
   while (i <= length(ayn)) and esValido do
   begin
      if not (upcase(ayn[i]) in ['A'..'Z', ' ']) then
         esValido := false;
      inc(i);
   end;
   escadena := esValido;
end;

function valoracion_valida(valoracion:byte):boolean;
begin
   if (valoracion >= 0) and (valoracion <= 4) then
      valoracion_valida := true
   else
      valoracion_valida := false;
end;

function tiene_formato_fecha(f: string): boolean;
begin
   if (Length(f) = 10) and (f[5] = '/') and (f[8] = '/') then
      tiene_formato_fecha := true
   else
      tiene_formato_fecha := false;
end;

function fecha_valida(fecha:string):boolean; {AAAA/MM/DD}
var
   dia, mes, anio: integer;
begin
   fecha_valida := false;
   if tiene_formato_fecha(fecha) then
   begin
     if TryStrToInt(copy(fecha, 1, 4), anio) and TryStrToInt(copy(fecha, 6, 2), mes) and TryStrToInt(copy(fecha, 9, 2), dia)  then
     begin
        if (anio >= 1900) and (anio <= 2026) then
        begin
           if (mes >= 1) and (mes <= 12) then
           begin
              case mes of
                 1,3,5,7,8,10,12: if (dia >= 1) and (dia <= 31) then
                                   fecha_valida := true;
                 4,6,9,11: if (dia >= 1) and (dia <= 30) then
                               fecha_valida := true;
                 2: if (anio mod 4 = 0) then
                     begin
                       if (dia >= 1) and (dia <= 29) then
                          fecha_valida := true;
                     end
                    else
                       if (dia >= 1) and (dia <= 28) then
                          fecha_valida := true;
              end;
           end;
        end;
     end;
   end;
end;

function nombre_valido(nombre: string): boolean;
var
  i, espacios, pos_espacio: integer;
  palabra1, palabra2: string;
begin
  nombre_valido := false;
  if Length(nombre) > 0 then
  begin
    if (nombre[1] <> ' ') and (nombre[Length(nombre)] <> ' ') then
    begin
      if escadena(nombre) then
      begin
        espacios := 0;
        pos_espacio := 0;
        for i := 1 to Length(nombre) do
        begin
          if nombre[i] = ' ' then
          begin
            espacios := espacios + 1;
            if espacios = 1 then
              pos_espacio := i;
          end;
        end;
        if espacios = 1 then
        begin
          palabra1 := Copy(nombre, 1, pos_espacio - 1);
          palabra2 := Copy(nombre, pos_espacio + 1, Length(nombre) - pos_espacio);
          if (palabra1[1] in ['A'..'Z']) and (palabra2[1] in ['A'..'Z']) then
          begin
            nombre_valido := true;
          end;
        end;
      end;
    end;
  end;
end;
end. 