unit UnitBusquedasPaises;

interface

uses
  UnitTiposPaises;

function BuscarPais(nombre: string): TPais;
function BuscarPaisPorCapital(capital: string): TPais;
procedure ListarPaisesPorRegion(region: string);
function ObtenerPaisAleatorio: TPais;
function ContarPaisesPorRegion(region: string): integer;
function ObtenerPaisPorIndice(indice: integer): TPais;
function ExistePais(nombre: string): boolean;

implementation

uses
  sysutils;

function BuscarPais(nombre: string): TPais;
var
  i: integer;
  encontrado: boolean;
begin
  encontrado := false;
  BuscarPais.activo := false;
  nombre := lowercase(nombre);
  i := 1;

  while (i <= cantidadPaises) and (not encontrado) do
  begin
    if pos(nombre, lowercase(paisesMemoria[i].nombre)) > 0 then
    begin
      BuscarPais := paisesMemoria[i];
      encontrado := true;
    end
    else
      i := i + 1;
  end;
end;

function BuscarPaisPorCapital(capital: string): TPais;
var
  i: integer;
  encontrado: boolean;
begin
  BuscarPaisPorCapital.activo := false;
  capital := lowercase(capital);
  i := 1;
  encontrado := false;

  while (i <= cantidadPaises) and (not encontrado) do
  begin
    if pos(capital, lowercase(paisesMemoria[i].capital)) > 0 then
    begin
      BuscarPaisPorCapital := paisesMemoria[i];
      encontrado := true;
    end
    else
      i := i + 1;
  end;
end;

procedure ListarPaisesPorRegion(region: string);
var
  i, contador: integer;
begin
  contador := 0;
  writeln('Paises de ', region, ':');
  writeln('----------------------------------------');

  for i := 1 to cantidadPaises do
  begin
    if lowercase(paisesMemoria[i].continente) = lowercase(region) then
    begin
      inc(contador);
      writeln('  ', contador, '. ', paisesMemoria[i].nombre,
              ' (Capital: ', paisesMemoria[i].capital, ')');
    end;
  end;

  if contador = 0 then
    writeln('  No encontre paises en esa region.');

  writeln('----------------------------------------');
  writeln('Total: ', contador, ' paises');
end;

function ObtenerPaisAleatorio: TPais;
var
  indice: integer;
begin
  if cantidadPaises > 0 then
  begin
    indice := random(cantidadPaises) + 1;
    ObtenerPaisAleatorio := paisesMemoria[indice];
  end
  else
    ObtenerPaisAleatorio.activo := false;
end;

function ContarPaisesPorRegion(region: string): integer;
var
  i, contador: integer;
begin
  contador := 0;
  for i := 1 to cantidadPaises do
  begin
    if lowercase(paisesMemoria[i].continente) = lowercase(region) then
      inc(contador);
  end;
  ContarPaisesPorRegion := contador;
end;

function ObtenerPaisPorIndice(indice: integer): TPais;
begin
  if (indice > 0) and (indice <= cantidadPaises) then
    ObtenerPaisPorIndice := paisesMemoria[indice]
  else
  begin
    ObtenerPaisPorIndice.activo := false;
    ObtenerPaisPorIndice.nombre := '';
  end;
end;

function ExistePais(nombre: string): boolean;
var
  pais: TPais;
begin
  pais := BuscarPais(nombre);
  ExistePais := pais.activo;
end;

end.

