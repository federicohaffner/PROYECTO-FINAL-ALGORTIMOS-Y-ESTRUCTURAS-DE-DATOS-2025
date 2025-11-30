unit UnitArchivosPaises;

interface

uses
  sysutils, UnitTiposPaises;

procedure InicializarSistema;
procedure CargarBaseDeDatos;
procedure CrearArchivoPaises;
procedure CerrarSistema;
procedure GuardarCambios;

implementation

var
  archivoPaises: TArchivoPaises;

procedure InicializarSistema;
begin
  cantidadPaises := 0;
  randomize;

  // Verificar si existe el archivo, si no, crearlo
  if not FileExists(ARCHIVO_PAISES) then
    CrearArchivoPaises;
end;

procedure CrearArchivoPaises;
var
  pais: TPais;
begin
  assign(archivoPaises, ARCHIVO_PAISES);
  rewrite(archivoPaises);

  // América del Norte
  pais.nombre := 'Canada';
  pais.capital := 'Ottawa';
  pais.latitud := 45.4215;
  pais.longitud := -75.6972;
  pais.continente := 'America del Norte';
  pais.poblacion := 38000000;
  pais.idioma := 'Ingles y Frances';
  pais.moneda := 'Dolar canadiense';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Estados Unidos';
  pais.capital := 'Washington D.C.';
  pais.latitud := 38.9072;
  pais.longitud := -77.0369;
  pais.continente := 'America del Norte';
  pais.poblacion := 331000000;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Mexico';
  pais.capital := 'Ciudad de Mexico';
  pais.latitud := 19.4326;
  pais.longitud := -99.1332;
  pais.continente := 'America del Norte';
  pais.poblacion := 128900000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso mexicano';
  pais.activo := true;
  write(archivoPaises, pais);

  // América Central
  pais.nombre := 'Guatemala';
  pais.capital := 'Ciudad de Guatemala';
  pais.latitud := 14.6349;
  pais.longitud := -90.5069;
  pais.continente := 'America Central';
  pais.poblacion := 17900000;
  pais.idioma := 'Español';
  pais.moneda := 'Quetzal';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'El Salvador';
  pais.capital := 'San Salvador';
  pais.latitud := 13.6929;
  pais.longitud := -89.2182;
  pais.continente := 'America Central';
  pais.poblacion := 6500000;
  pais.idioma := 'Español';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Honduras';
  pais.capital := 'Tegucigalpa';
  pais.latitud := 14.0723;
  pais.longitud := -87.1921;
  pais.continente := 'America Central';
  pais.poblacion := 9900000;
  pais.idioma := 'Español';
  pais.moneda := 'Lempira';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Nicaragua';
  pais.capital := 'Managua';
  pais.latitud := 12.1149;
  pais.longitud := -86.2362;
  pais.continente := 'America Central';
  pais.poblacion := 6600000;
  pais.idioma := 'Español';
  pais.moneda := 'Cordoba';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Costa Rica';
  pais.capital := 'San Jose';
  pais.latitud := 9.9281;
  pais.longitud := -84.0907;
  pais.continente := 'America Central';
  pais.poblacion := 5100000;
  pais.idioma := 'Español';
  pais.moneda := 'Colon costarricense';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Panama';
  pais.capital := 'Ciudad de Panama';
  pais.latitud := 8.9824;
  pais.longitud := -79.5199;
  pais.continente := 'America Central';
  pais.poblacion := 4300000;
  pais.idioma := 'Español';
  pais.moneda := 'Balboa y Dolar';
  pais.activo := true;
  write(archivoPaises, pais);

  // Caribe
  pais.nombre := 'Cuba';
  pais.capital := 'La Habana';
  pais.latitud := 23.1136;
  pais.longitud := -82.3666;
  pais.continente := 'Caribe';
  pais.poblacion := 11300000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso cubano';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Jamaica';
  pais.capital := 'Kingston';
  pais.latitud := 18.0179;
  pais.longitud := -76.8099;
  pais.continente := 'Caribe';
  pais.poblacion := 2700000;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar jamaiquino';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Haiti';
  pais.capital := 'Puerto Principe';
  pais.latitud := 18.5944;
  pais.longitud := -72.3074;
  pais.continente := 'Caribe';
  pais.poblacion := 11400000;
  pais.idioma := 'Frances y Criollo';
  pais.moneda := 'Gourde';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Republica Dominicana';
  pais.capital := 'Santo Domingo';
  pais.latitud := 18.4861;
  pais.longitud := -69.9312;
  pais.continente := 'Caribe';
  pais.poblacion := 10800000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso dominicano';
  pais.activo := true;
  write(archivoPaises, pais);

  // América del Sur
  pais.nombre := 'Colombia';
  pais.capital := 'Bogota';
  pais.latitud := 4.7110;
  pais.longitud := -74.0721;
  pais.continente := 'America del Sur';
  pais.poblacion := 50900000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso colombiano';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Venezuela';
  pais.capital := 'Caracas';
  pais.latitud := 10.4806;
  pais.longitud := -66.9036;
  pais.continente := 'America del Sur';
  pais.poblacion := 28400000;
  pais.idioma := 'Español';
  pais.moneda := 'Bolivar';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Brasil';
  pais.capital := 'Brasilia';
  pais.latitud := -15.8267;
  pais.longitud := -47.9218;
  pais.continente := 'America del Sur';
  pais.poblacion := 212600000;
  pais.idioma := 'Portugues';
  pais.moneda := 'Real brasileño';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Peru';
  pais.capital := 'Lima';
  pais.latitud := -12.0464;
  pais.longitud := -77.0428;
  pais.continente := 'America del Sur';
  pais.poblacion := 33000000;
  pais.idioma := 'Español';
  pais.moneda := 'Sol';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Ecuador';
  pais.capital := 'Quito';
  pais.latitud := -0.1807;
  pais.longitud := -78.4678;
  pais.continente := 'America del Sur';
  pais.poblacion := 17600000;
  pais.idioma := 'Español';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Bolivia';
  pais.capital := 'La Paz';
  pais.latitud := -16.5000;
  pais.longitud := -68.1500;
  pais.continente := 'America del Sur';
  pais.poblacion := 11700000;
  pais.idioma := 'Español';
  pais.moneda := 'Boliviano';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Chile';
  pais.capital := 'Santiago';
  pais.latitud := -33.4489;
  pais.longitud := -70.6693;
  pais.continente := 'America del Sur';
  pais.poblacion := 19100000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso chileno';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Argentina';
  pais.capital := 'Buenos Aires';
  pais.latitud := -34.6037;
  pais.longitud := -58.3816;
  pais.continente := 'America del Sur';
  pais.poblacion := 45200000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso argentino';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Uruguay';
  pais.capital := 'Montevideo';
  pais.latitud := -34.9011;
  pais.longitud := -56.1645;
  pais.continente := 'America del Sur';
  pais.poblacion := 3500000;
  pais.idioma := 'Español';
  pais.moneda := 'Peso uruguayo';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Paraguay';
  pais.capital := 'Asuncion';
  pais.latitud := -25.2637;
  pais.longitud := -57.5759;
  pais.continente := 'America del Sur';
  pais.poblacion := 7100000;
  pais.idioma := 'Español y Guarani';
  pais.moneda := 'Guarani';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Guyana';
  pais.capital := 'Georgetown';
  pais.latitud := 6.8013;
  pais.longitud := -58.1551;
  pais.continente := 'America del Sur';
  pais.poblacion := 786000;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar guayanes';
  pais.activo := true;
  write(archivoPaises, pais);

  pais.nombre := 'Surinam';
  pais.capital := 'Paramaribo';
  pais.latitud := 5.8520;
  pais.longitud := -55.2038;
  pais.continente := 'America del Sur';
  pais.poblacion := 587000;
  pais.idioma := 'Holandes';
  pais.moneda := 'Dolar surinames';
  pais.activo := true;
  write(archivoPaises, pais);

  close(archivoPaises);
end;

procedure CargarBaseDeDatos;
var
  pais: TPais;
begin
  assign(archivoPaises, ARCHIVO_PAISES);
  reset(archivoPaises);
  cantidadPaises := 0;

  while not eof(archivoPaises) and (cantidadPaises < MAX_PAISES) do
  begin
    read(archivoPaises, pais);
    if pais.activo then
    begin
      inc(cantidadPaises);
      paisesMemoria[cantidadPaises] := pais;
    end;
  end;

  close(archivoPaises);
end;

procedure GuardarCambios;
var
  i: integer;
begin
  assign(archivoPaises, ARCHIVO_PAISES);
  rewrite(archivoPaises);

  for i := 1 to cantidadPaises do
  begin
    write(archivoPaises, paisesMemoria[i]);
  end;

  close(archivoPaises);
end;

procedure CerrarSistema;
begin
  // Guardar cambios si es necesario
  // GuardarCambios;
end;

end.

