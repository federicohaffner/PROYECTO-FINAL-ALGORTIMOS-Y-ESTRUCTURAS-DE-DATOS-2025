unit Validaciones;
{$mode ObjFPC}{$H+}

interface
uses
   SysUtils, Classes;
function legajo_valido(legajo:string):boolean;
function escadena(ayn: string): boolean;
function fecha_valida(fecha:string):boolean; {AAAA/MM/DD}
function valoracion_valida(valoracion:byte):boolean;

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

function fecha_valida(fecha:string):boolean; {AAAA/MM/DD}
var
   dia, mes, anio: integer;
   sep1, sep2: char;
begin
   val(copy(fecha,1,4), anio);
   sep1 := fecha[5];
   val(copy(fecha,6,2), mes);
   sep2 := fecha[8];
   val(copy(fecha,9,2), dia);
   fecha_valida := false;
   if (sep1 = '/') and (sep2 = '/') then
   begin
      if (anio >= 1900) and (anio <= 2100) then
      begin
         if (mes >= 1) and (mes <= 12) then
         begin
            case mes of
               1,3,5,7,8,10,12: if (dia >= 1) and (dia <= 31) then
                                 fecha_valida := true;
               4,6,9,11: if (dia >= 1) and (dia <= 30) then
                             fecha_valida := true;
               2: if (anio mod 4 = 0) then
                     if (dia >= 1) and (dia <= 29) then
                        fecha_valida := true
                  else
                     if (dia >= 1) and (dia <= 28) then
                        fecha_valida := true;
            end;
         end;
      end;
   end;
end;

function valoracion_valida(valoracion:byte):boolean;
begin
   if (valoracion >= 0) and (valoracion <= 4) then
      valoracion_valida := true
   else
      valoracion_valida := false;
end;


end.