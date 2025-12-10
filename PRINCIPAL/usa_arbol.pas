unit usa_arbol;
{$mode ObjFPC}{$H+}

interface
uses
    unit_arbol, archivos,  crt;

procedure crear_arbol (var raiz:t_punt);
procedure agregar (var raiz:t_punt; x:t_dato_arbol);
procedure agregar_arbol_eval(var raiz:t_punt; x:t_dato_arbol);
procedure preorden(raiz:t_punt; buscado:string; var enc:boolean; var x:t_dato_arbol);
procedure inorden(var raiz:t_punt);
procedure suprime(var raiz:t_punt; x:t_dato_arbol);
function suprime_min(var raiz:t_punt):t_dato_arbol;
procedure inorden_leg(raiz: t_punt; legajo_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
procedure inorden_disc(raiz: t_punt; disc: byte; var arch: t_archivo_alumnos; var linea: integer);
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
   if (raiz^.info.clave > x.clave) then
      agregar (raiz^.sai, x)
   else
      agregar (raiz^.sad, x)
end;

procedure agregar_arbol_eval(var raiz:t_punt; x:t_dato_arbol);
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
      if x.clave < raiz^.info.clave then
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
      inorden (raiz^.sad);
   end;
end;

procedure inorden_leg(raiz: t_punt; legajo_buscado: string; var linea: integer; var e: t_archivo_evaluaciones);
var
  legajo_en_nodo: string;
  reg: t_dato_evaluaciones;
  i: integer;
begin
  if raiz <> nil then
  begin
    inorden_leg(raiz^.sai, legajo_buscado, linea, e);
    if Length(raiz^.info.clave) > 11 then
    begin
         legajo_en_nodo := Copy(raiz^.info.clave, 12, Length(raiz^.info.clave)-11);
         if legajo_en_nodo = legajo_buscado then
         begin
            seek(e, raiz^.info.pos_arch);
            read(e, reg);
            textcolor(White);
            gotoxy(10, linea); write(reg.fecha_ev);
            gotoxy(30, linea); write(Copy(reg.observacion, 1, 25));
            if Length(reg.observacion) > 25 then write('...');
            gotoxy(60, linea);
            for i := 1 to 5 do
            begin
                 if reg.valoracion[i] > 0 then textcolor(White) else textcolor(DarkGray);
                 write(reg.valoracion[i]);
                 textcolor(LightGray);
                 if i < 5 then write(',');
            end;
            linea := linea + 1;
            if linea > 21 then linea := 21;
         end;
    end;
    inorden_leg(raiz^.sad, legajo_buscado, linea, e);
  end;
end;

procedure inorden_disc(raiz: t_punt; disc: byte; var arch: t_archivo_alumnos; var linea: integer);
var
  r: t_dato_alumnos;
begin
  if raiz <> nil then
  begin
    inorden_disc(raiz^.sai, disc, arch, linea);
    seek(arch, raiz^.info.pos_arch);
    read(arch, r);
    if (r.estado = true) and (r.discapacidades[disc] = true) then
    begin
       gotoxy(10, linea); Write('Alumno: ', r.ayn);
       gotoxy(50, linea); Write('Legajo: ', r.legajo);
       linea:=linea+1
    end;
    inorden_disc(raiz^.sad, disc, arch, linea);
  end;
end;

procedure inorden_alumnos_activos(raiz: t_punt; var a: t_archivo_alumnos; var linea: integer);
var
   reg: t_dato_alumnos;
begin
   if raiz <> nil then
   begin
      inorden_alumnos_activos(raiz^.sai, a, linea);
      seek(a, raiz^.info.pos_arch);
      read(a, reg);
      if reg.estado = true then
      begin
           linea := linea + 1;
           if linea > 22 then
           begin
               gotoxy(10, 24); write('Presione una tecla para continuar...');
               readkey;
               clrscr;
               linea := 4;
           end;
           gotoxy(10, linea); write(reg.ayn);
           gotoxy(50, linea); write(reg.legajo);
           linea := linea + 1;
      end;
      inorden_alumnos_activos(raiz^.sad, a, linea);
   end;
end;

end.