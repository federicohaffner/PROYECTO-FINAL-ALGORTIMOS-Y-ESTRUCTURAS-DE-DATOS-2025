unit Busqueda_paises;

interface

uses
  sysutils,Declaracion_paises;

function BuscarPais(nombre: string; vector: t_vector_pais; cantidad: integer): t_dato_pais;
function BuscarPaisPorCapital(capital: string; vector: t_vector_pais; cantidad: integer): t_dato_pais;
procedure ListarPaisesPorRegion(region: string; vector: t_vector_pais; cantidad: integer);
function ObtenerPaisAleatorio(vector: t_vector_pais; cantidad: integer): t_dato_pais;
function ContarPaisesPorRegion(region: string; vector: t_vector_pais; cantidad: integer): integer;

implementation


function BuscarPais(nombre: string; vector: t_vector_pais; cantidad: integer): t_dato_pais;
var
  i: integer;
  encontrado: boolean;
begin
  encontrado := false;
  BuscarPais.activo := false;
  nombre := lowercase(nombre);
  i := 1;

  while (i <= cantidad) and (not encontrado) do
  begin
    if pos(nombre, lowercase(vector[i].nombre)) > 0 then
    begin
      BuscarPais := vector[i];
      encontrado := true;
    end
    else
     inc(i);
  end;
end;

function BuscarPaisPorCapital(capital: string; vector: t_vector_pais; cantidad: integer): t_dato_pais;
var
  i: integer;
  encontrado: boolean;
begin
  BuscarPaisPorCapital.activo := false;
  capital := lowercase(capital);
  i := 1;
  encontrado := false;

  while (i <= cantidad) and (not encontrado) do
  begin
    if pos(capital, lowercase(vector[i].capital)) > 0 then
    begin
      BuscarPaisPorCapital := vector[i];
      encontrado := true;
    end
    else
      inc(i);
  end;
end;

procedure ListarPaisesPorRegion(region: string; vector: t_vector_pais; cantidad: integer);
var
  i, contador: integer;
begin
  contador := 0;
  writeln('Paises de ', region, ':');
  writeln('----------------------------------------');

  for i := 1 to cantidad do
  begin
    if lowercase(vector[i].continente) = lowercase(region) then
    begin
      inc(contador);
      writeln('  ', contador, '. ', vector[i].nombre,
              ' (Capital: ', vector[i].capital, ')');
    end;
  end;
  if contador = 0 then
    writeln('  No encontre paises en esa region.');

  writeln('----------------------------------------');
  writeln('Total: ', contador, ' paises');
end;

function ObtenerPaisAleatorio(vector: t_vector_pais; cantidad: integer): t_dato_pais;
var
  indice: integer;
begin
  if cantidad > 0 then
  begin
    indice := random(cantidad) + 1;
    ObtenerPaisAleatorio := vector[indice];
  end
  else
    ObtenerPaisAleatorio.activo := false;
end;

function ContarPaisesPorRegion(region: string; vector: t_vector_pais; cantidad: integer): integer;
var
  i, contador: integer;
begin
  contador := 0;
  for i := 1 to cantidad do
  begin
    if lowercase(vector[i].continente) = lowercase(region) then
      inc(contador);
  end;
  ContarPaisesPorRegion := contador;
end;
end. 
