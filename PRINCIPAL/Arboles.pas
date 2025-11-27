unit unit_arbol;
{$mode ObjFPC}{$H+}
interface
uses
   crt, sysutils;

type
   t_dato_arbol = record
      clave: string[100];
      pos_arch: word;
   end;

   t_punt = ^t_nodo;

   t_nodo = record
      info: t_dato_arbol;
      sai, sad: t_punt;
   end;

procedure crear_arbol (var raiz:t_punt);
procedure agregar (var raiz:t_punt; x:t_dato_arbol);
function arbol_vacio (raiz:t_punt): boolean;
function arbol_lleno (raiz:t_punt): boolean;
procedure agregar_arbol_eval(var raiz:t_punt; x:t_dato_arbol);
procedure inorden(var raiz:t_punt);
procedure preorden(raiz:t_punt; buscado:string; var enc:boolean; var x:t_dato_arbol);
procedure suprime(var raiz:t_punt; x:t_dato_arbol);
function suprime_min(var raiz:t_punt):t_dato_arbol;

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
   if (raiz^.info.clave > x.clave) then
      agregar (raiz^.sai, x)
   else
      agregar (raiz^.sad, x)
end;

procedure agregar_arbol_eval(var raiz:t_punt; x:t_dato_arbol);
var
   menor: boolean;
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
      menor:=evalua_fecha_leg_mayor(raiz^.info.clave, x.clave);
      if menor then
         agregar_arbol_eval(raiz^.sai, x)
      else
         agregar_arbol_eval(raiz^.sad, x);
   end;
end;

function arbol_vacio (raiz:t_punt): boolean;
begin
   arbol_vacio := raiz = nil;
end;

function arbol_lleno (raiz:t_punt): boolean;
begin
   arbol_lleno := getheapstatus.totalfree < sizeof (t_nodo);
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
      writeln (raiz^.info.pos_arch);
      inorden (raiz^.sad);
   end;
end;

procedure arbol_en_memoria(var archivo_1:t_archivo_alumnos; var archivo_2:t_archivo_evaluaciones; var raiz, raiz_2, raiz_3:t_punt);
begin
   crear_abrir(archivo_1);
   crear_abrir_2(archivo_2);
   if not (archivo_vacio(archivo_1)) then
      genera_arboles_alum(archivo_1, raiz, raiz_2)
   else
   begin
      crear_arbol(raiz);
      crear_arbol(raiz_2);
   end;
   if not (archivo_vacio(archivo_2)) then
      genera_arbol_eval(archivo_2, raiz_3)
   else
      crear_arbol(raiz_3);
end;
end.
