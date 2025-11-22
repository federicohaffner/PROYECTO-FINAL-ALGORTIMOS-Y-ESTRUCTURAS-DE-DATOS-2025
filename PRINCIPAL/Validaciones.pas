unit unit_name;
    
interface
    
uses
    SysUtils, Classes;
    
implementation
    
function longitud(clave:t_dato_arbol): byte;
var
  aux:string;
  i:byte;
begin
   aux:='';
   i:=0;
   longitud:=0;
   while aux<>' ' do
   begin
      aux:=copy(clave,i,i+1);
      longitud:=longitud+1;
      i:=i+1;
   end;
end;
    
end.