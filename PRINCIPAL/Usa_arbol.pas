unit Usa_arbol;
{$mode ObjFPC}{$H+}

interface
uses
   SysUtils, Unit_arbol, Crt;

procedure crear_arbol (var raiz:t_punt);
procedure agregar (var raiz:t_punt; x:t_dato_arbol);
procedure preorden(raiz:t_punt; buscado:string; var enc:boolean; var x:t_dato_arbol);
procedure inorden(var raiz:t_punt);
procedure suprime(var raiz:t_punt; x:t_dato_arbol);
function suprime_min(var raiz:t_punt):t_dato_arbol;
function arbol_vacio (raiz:t_punt): boolean;
function arbol_lleno (raiz:t_punt): boolean;

implementation

procedure crear_arbol (var raiz:t_punt);
begin
   raiz:= nil;
end;

procedure agregar (var raiz:t_punt; x:t_dato_arbol);
begin
   if raiz = nil then
   begin
      new(raiz);
      raiz^.info := x;
      raiz^.sai := nil;
      raiz^.sad := nil;
   end
   else
   begin
     if (raiz^.info.clave > x.clave) then
        agregar (raiz^.sai, x)
     else
        agregar (raiz^.sad, x)
   end;
end;

procedure preorden(raiz:t_punt; buscado:string; var enc:boolean; var x:t_dato_arbol);
begin
   if (raiz = nil) then
      enc := false
   else
   if (upcase(raiz^.info.clave) = upcase(buscado)) then
   begin
      enc := true;
      x := raiz^.info;
   end
   else
   if upcase(raiz^.info.clave) > upcase(buscado) then
      preorden(raiz^.sai,buscado, enc, x)
   else
      preorden(raiz^.sad, buscado, enc, x);
end;

procedure inorden(var raiz:t_punt);
begin
   if raiz <> nil then
   begin
      inorden (raiz^.sai);
      writeln (raiz^.info.clave);
      inorden (raiz^.sad);
   end;
end;

procedure suprime(var raiz:t_punt; x:t_dato_arbol);
begin
   if raiz <> nil then
   begin
      if upcase(x.clave) < upcase(raiz^.info.clave) then
         suprime(raiz^.sai, x)
      else
      if upcase(x.clave) > upcase(raiz^.info.clave) then
         suprime (raiz^.sad, x)
      else
      if (raiz^.sai = nil) and (raiz^.sad = nil) then
         raiz := nil
      else
      if (raiz^.sai = nil) then
         raiz := raiz^.sad
      else
      if (raiz^.sad = nil) then
         raiz := raiz^.sai
      else
         raiz^.info := suprime_min (raiz^.sad)
   end;
end;

function suprime_min(var raiz:t_punt):t_dato_arbol;
var
   dir: t_punt;
begin
   if raiz^.sai = nil then
   begin
      suprime_min := raiz^.info;
      dir := raiz;
      raiz := raiz^.sad;
      dispose (dir);
   end
   else
      suprime_min := suprime_min (raiz^.sai);
end;

function arbol_vacio (raiz:t_punt): boolean;
begin
   arbol_vacio := raiz = nil;
end;

function arbol_lleno (raiz:t_punt): boolean;
begin
   arbol_lleno := getheapstatus.totalfree < sizeof (t_nodo);
end;
end. 