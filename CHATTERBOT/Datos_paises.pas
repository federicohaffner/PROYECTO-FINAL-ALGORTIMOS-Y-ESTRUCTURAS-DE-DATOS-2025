unit Datos_paises;

interface

uses
  sysutils, Declaracion_paises;

procedure Inicializar(var vector: t_vector_pais; var cantidad: integer);
procedure Creararch_paises;
procedure CargarBaseDeDatos(var vector: t_vector_pais; var cantidad: integer);
procedure GuardarCambios(vector: t_vector_pais; cantidad: integer);

implementation

procedure Inicializar(var vector: t_vector_pais; var cantidad: integer);
begin
  cantidad := 0;
  randomize;
  if not FileExists('paises.dat') then
    Creararch_paises;
end;

procedure Creararch_paises;
var
  arch_paises: t_arch_paises;
  pais: t_dato_pais;
begin
  assign(arch_paises, 'paises.dat');
  rewrite(arch_paises);

  //  AMÉRICA DEL NORTE
  pais.nombre := 'Canada';
  pais.capital := 'Ottawa';
  pais.continente := 'America del Norte';
  pais.poblacion := 38000000;
  pais.superficie := 9984670;
  pais.idioma := 'Ingles y Frances';
  pais.moneda := 'Dolar canadiense';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Estados Unidos';
  pais.capital := 'Washington D.C.';
  pais.continente := 'America del Norte';
  pais.poblacion := 331000000;
  pais.superficie := 9833520;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Mexico';
  pais.capital := 'Ciudad de Mexico';
  pais.continente := 'America del Norte';
  pais.poblacion := 128900000;
  pais.superficie := 1964375;
  pais.idioma := 'Español';
  pais.moneda := 'Peso mexicano';
  pais.activo := true;
  write(arch_paises, pais);

  //  AMÉRICA CENTRAL
  pais.nombre := 'Guatemala';
  pais.capital := 'Ciudad de Guatemala';
  pais.continente := 'America Central';
  pais.poblacion := 17900000;
  pais.superficie := 108889;
  pais.idioma := 'Español';
  pais.moneda := 'Quetzal';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'El Salvador';
  pais.capital := 'San Salvador';
  pais.continente := 'America Central';
  pais.poblacion := 6500000;
  pais.superficie := 21041;
  pais.idioma := 'Español';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Honduras';
  pais.capital := 'Tegucigalpa';
  pais.continente := 'America Central';
  pais.poblacion := 9900000;
  pais.superficie := 112492;
  pais.idioma := 'Español';
  pais.moneda := 'Lempira';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Nicaragua';
  pais.capital := 'Managua';
  pais.continente := 'America Central';
  pais.poblacion := 6600000;
  pais.superficie := 130373;
  pais.idioma := 'Español';
  pais.moneda := 'Cordoba';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Costa Rica';
  pais.capital := 'San Jose';
  pais.continente := 'America Central';
  pais.poblacion := 5100000;
  pais.superficie := 51100;
  pais.idioma := 'Español';
  pais.moneda := 'Colon costarricense';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Panama';
  pais.capital := 'Ciudad de Panama';
  pais.continente := 'America Central';
  pais.poblacion := 4300000;
  pais.superficie := 75417;
  pais.idioma := 'Español';
  pais.moneda := 'Balboa y Dolar';
  pais.activo := true;
  write(arch_paises, pais);

  //  CARIBE
  pais.nombre := 'Cuba';
  pais.capital := 'La Habana';
  pais.continente := 'Caribe';
  pais.poblacion := 11300000;
  pais.superficie := 109884;
  pais.idioma := 'Español';
  pais.moneda := 'Peso cubano';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Jamaica';
  pais.capital := 'Kingston';
  pais.continente := 'Caribe';
  pais.poblacion := 2700000;
  pais.superficie := 10991;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar jamaiquino';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Haiti';
  pais.capital := 'Puerto Principe';
  pais.continente := 'Caribe';
  pais.poblacion := 11400000;
  pais.superficie := 27750;
  pais.idioma := 'Frances y Criollo';
  pais.moneda := 'Gourde';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Republica Dominicana';
  pais.capital := 'Santo Domingo';
  pais.continente := 'Caribe';
  pais.poblacion := 10800000;
  pais.superficie := 48671;
  pais.idioma := 'Español';
  pais.moneda := 'Peso dominicano';
  pais.activo := true;
  write(arch_paises, pais);

  //  AMÉRICA DEL SUR
  pais.nombre := 'Colombia';
  pais.capital := 'Bogota';
  pais.continente := 'America del Sur';
  pais.poblacion := 50900000;
  pais.superficie := 1141748;
  pais.idioma := 'Español';
  pais.moneda := 'Peso colombiano';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Venezuela';
  pais.capital := 'Caracas';
  pais.continente := 'America del Sur';
  pais.poblacion := 28400000;
  pais.superficie := 916445;
  pais.idioma := 'Español';
  pais.moneda := 'Bolivar';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Brasil';
  pais.capital := 'Brasilia';
  pais.continente := 'America del Sur';
  pais.poblacion := 212600000;
  pais.superficie := 8515767;
  pais.idioma := 'Portugues';
  pais.moneda := 'Real brasileño';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Peru';
  pais.capital := 'Lima';
  pais.continente := 'America del Sur';
  pais.poblacion := 33000000;
  pais.superficie := 1285216;
  pais.idioma := 'Español';
  pais.moneda := 'Sol';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Ecuador';
  pais.capital := 'Quito';
  pais.continente := 'America del Sur';
  pais.poblacion := 17600000;
  pais.superficie := 283561;
  pais.idioma := 'Español';
  pais.moneda := 'Dolar estadounidense';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Bolivia';
  pais.capital := 'La Paz';
  pais.continente := 'America del Sur';
  pais.poblacion := 11700000;
  pais.superficie := 1098581;
  pais.idioma := 'Español';
  pais.moneda := 'Boliviano';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Chile';
  pais.capital := 'Santiago';
  pais.continente := 'America del Sur';
  pais.poblacion := 19100000;
  pais.superficie := 756102;
  pais.idioma := 'Español';
  pais.moneda := 'Peso chileno';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Argentina';
  pais.capital := 'Buenos Aires';
  pais.continente := 'America del Sur';
  pais.poblacion := 45200000;
  pais.superficie := 2780400;
  pais.idioma := 'Español';
  pais.moneda := 'Peso argentino';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Uruguay';
  pais.capital := 'Montevideo';
  pais.continente := 'America del Sur';
  pais.poblacion := 3500000;
  pais.superficie := 176215;
  pais.idioma := 'Español';
  pais.moneda := 'Peso uruguayo';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Paraguay';
  pais.capital := 'Asuncion';
  pais.continente := 'America del Sur';
  pais.poblacion := 7100000;
  pais.superficie := 406752;
  pais.idioma := 'Español y Guarani';
  pais.moneda := 'Guarani';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Guyana';
  pais.capital := 'Georgetown';
  pais.continente := 'America del Sur';
  pais.poblacion := 786000;
  pais.superficie := 214969;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar guayanes';
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Surinam';
  pais.capital := 'Paramaribo';
  pais.continente := 'America del Sur';
  pais.poblacion := 587000;
  pais.superficie := 163820;
  pais.idioma := 'Holandes';
  pais.moneda := 'Dolar surinames';
  pais.activo := true;
  write(arch_paises, pais);

  close(arch_paises);
end;

procedure CargarBaseDeDatos(var vector: t_vector_pais; var cantidad: integer);
var
  arch_paises: t_arch_paises;
  pais: t_dato_pais;
begin
  assign(arch_paises, 'paises.dat');
  reset(arch_paises);
  cantidad := 0;

  while not eof(arch_paises) and (cantidad < paises_max) do
  begin
    read(arch_paises, pais);
    if pais.activo then
    begin
      inc(cantidad);
      vector[cantidad] := pais;
    end;
  end;

  close(arch_paises);
end;

procedure GuardarCambios(vector: t_vector_pais; cantidad: integer);
var
  arch_paises: t_arch_paises;
  i: integer;
begin
  assign(arch_paises, 'paises.dat');
  rewrite(arch_paises);

  for i := 1 to cantidad do
  begin
    write(arch_paises, vector[i]);
  end;

  close(arch_paises);
end;

end.

               