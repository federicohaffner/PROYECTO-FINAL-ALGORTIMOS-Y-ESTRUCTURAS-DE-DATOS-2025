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
  pais.limitrofes := 'Estados Unidos';
  pais.independencia := '1 de julio de 1867';
  pais.comida_tipica := 'Poutine (papas fritas con queso y gravy)';
  pais.punto_alto := 'Monte Logan';
  pais.altura_max := 5959;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Estados Unidos';
  pais.capital := 'Washington D.C.';
  pais.continente := 'America del Norte';
  pais.poblacion := 331000000;
  pais.superficie := 9833520;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar estadounidense';
  pais.limitrofes := 'Canada,Mexico';
  pais.independencia := '4 de julio de 1776';
  pais.comida_tipica := 'Hamburguesa, hot dog, barbecue';
  pais.punto_alto := 'Monte McKinley (Denali)';
  pais.altura_max := 6190;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Mexico';
  pais.capital := 'Ciudad de Mexico';
  pais.continente := 'America del Norte';
  pais.poblacion := 128900000;
  pais.superficie := 1964375;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso mexicano';
  pais.limitrofes := 'Estados Unidos,Guatemala';
  pais.independencia := '16 de septiembre de 1810';
  pais.comida_tipica := 'Tacos, mole, tamales';
  pais.punto_alto := 'Pico de Orizaba';
  pais.altura_max := 5636;
  pais.activo := true;
  write(arch_paises, pais);

  //  AMÉRICA CENTRAL 
  pais.nombre := 'Guatemala';
  pais.capital := 'Ciudad de Guatemala';
  pais.continente := 'America Central';
  pais.poblacion := 17900000;
  pais.superficie := 108889;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Quetzal';
  pais.limitrofes := 'Mexico,Honduras,El Salvador';
  pais.independencia := '15 de septiembre de 1821';
  pais.comida_tipica := 'Pepian, kak ik (sopa de pavo)';
  pais.punto_alto := 'Volcan Tajumulco';
  pais.altura_max := 4220;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'El Salvador';
  pais.capital := 'San Salvador';
  pais.continente := 'America Central';
  pais.poblacion := 6500000;
  pais.superficie := 21041;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Dolar estadounidense';
  pais.limitrofes := 'Guatemala,Honduras';
  pais.independencia := '15 de septiembre de 1821';
  pais.comida_tipica := 'Pupusas';
  pais.punto_alto := 'Cerro El Pital';
  pais.altura_max := 2730;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Honduras';
  pais.capital := 'Tegucigalpa';
  pais.continente := 'America Central';
  pais.poblacion := 9900000;
  pais.superficie := 112492;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Lempira';
  pais.limitrofes := 'Guatemala,El Salvador,Nicaragua';
  pais.independencia := '15 de septiembre de 1821';
  pais.comida_tipica := 'Baleadas, sopa de caracol';
  pais.punto_alto := 'Cerro Las Minas';
  pais.altura_max := 2870;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Nicaragua';
  pais.capital := 'Managua';
  pais.continente := 'America Central';
  pais.poblacion := 6600000;
  pais.superficie := 130373;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Cordoba';
  pais.limitrofes := 'Honduras,Costa Rica';
  pais.independencia := '15 de septiembre de 1821';
  pais.comida_tipica := 'Gallo pinto, vigoron';
  pais.punto_alto := 'Mogoton';
  pais.altura_max := 2107;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Costa Rica';
  pais.capital := 'San Jose';
  pais.continente := 'America Central';
  pais.poblacion := 5100000;
  pais.superficie := 51100;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Colon costarricense';
  pais.limitrofes := 'Nicaragua,Panama';
  pais.independencia := '15 de septiembre de 1821';
  pais.comida_tipica := 'Gallo pinto, casado';
  pais.punto_alto := 'Cerro Chirripo';
  pais.altura_max := 3821;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Panama';
  pais.capital := 'Ciudad de Panama';
  pais.continente := 'America Central';
  pais.poblacion := 4300000;
  pais.superficie := 75417;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Balboa y Dolar';
  pais.limitrofes := 'Costa Rica,Colombia';
  pais.independencia := '3 de noviembre de 1903 (de Colombia)';
  pais.comida_tipica := 'Sancocho, arroz con pollo';
  pais.punto_alto := 'Volcan Baru';
  pais.altura_max := 3475;
  pais.activo := true;
  write(arch_paises, pais);

  //  CARIBE 
  pais.nombre := 'Cuba';
  pais.capital := 'La Habana';
  pais.continente := 'Caribe';
  pais.poblacion := 11300000;
  pais.superficie := 109884;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso cubano';
  pais.limitrofes := 'ninguno';
  pais.independencia := '20 de mayo de 1902 (de Espania)';
  pais.comida_tipica := 'Ropa vieja, moros y cristianos';
  pais.punto_alto := 'Pico Turquino';
  pais.altura_max := 1974;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Jamaica';
  pais.capital := 'Kingston';
  pais.continente := 'Caribe';
  pais.poblacion := 2700000;
  pais.superficie := 10991;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar jamaiquino';
  pais.limitrofes := 'ninguno';
  pais.independencia := '6 de agosto de 1962 (del Reino Unido)';
  pais.comida_tipica := 'Jerk chicken, ackee and saltfish';
  pais.punto_alto := 'Blue Mountain Peak';
  pais.altura_max := 2256;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Haiti';
  pais.capital := 'Puerto Principe';
  pais.continente := 'Caribe';
  pais.poblacion := 11400000;
  pais.superficie := 27750;
  pais.idioma := 'Frances y Criollo';
  pais.moneda := 'Gourde';
  pais.limitrofes := 'Republica Dominicana';
  pais.independencia := '1 de enero de 1804 (de Francia)';
  pais.comida_tipica := 'Griot (cerdo frito), diri ak djon djon';
  pais.punto_alto := 'Pic la Selle';
  pais.altura_max := 2680;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Republica Dominicana';
  pais.capital := 'Santo Domingo';
  pais.continente := 'Caribe';
  pais.poblacion := 10800000;
  pais.superficie := 48671;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso dominicano';
  pais.limitrofes := 'Haiti';
  pais.independencia := '27 de febrero de 1844 (de Haiti)';
  pais.comida_tipica := 'Sancocho, mangu, bandera dominicana';
  pais.punto_alto := 'Pico Duarte';
  pais.altura_max := 3098;
  pais.activo := true;
  write(arch_paises, pais);

  //  AMÉRICA DEL SUR 
  pais.nombre := 'Colombia';
  pais.capital := 'Bogota';
  pais.continente := 'America del Sur';
  pais.poblacion := 50900000;
  pais.superficie := 1141748;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso colombiano';
  pais.limitrofes := 'Panama,Venezuela,Brasil,Peru,Ecuador';
  pais.independencia := '20 de julio de 1810';
  pais.comida_tipica := 'Bandeja paisa, arepas, ajiaco';
  pais.punto_alto := 'Pico Cristobal Colon';
  pais.altura_max := 5700;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Venezuela';
  pais.capital := 'Caracas';
  pais.continente := 'America del Sur';
  pais.poblacion := 28400000;
  pais.superficie := 916445;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Bolivar';
  pais.limitrofes := 'Colombia,Brasil,Guyana';
  pais.independencia := '5 de julio de 1811';
  pais.comida_tipica := 'Arepas, pabellon criollo, hallacas';
  pais.punto_alto := 'Pico Bolivar';
  pais.altura_max := 4978;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Brasil';
  pais.capital := 'Brasilia';
  pais.continente := 'America del Sur';
  pais.poblacion := 212600000;
  pais.superficie := 8515767;
  pais.idioma := 'Portugues';
  pais.moneda := 'Real brasilenio';
  pais.limitrofes := 'Venezuela,Colombia,Peru,Bolivia,Paraguay,Argentina,Uruguay,Guyana,Surinam';
  pais.independencia := '7 de septiembre de 1822 (de Portugal)';
  pais.comida_tipica := 'Feijoada, churrasco, acaraje';
  pais.punto_alto := 'Pico da Neblina';
  pais.altura_max := 2994;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Peru';
  pais.capital := 'Lima';
  pais.continente := 'America del Sur';
  pais.poblacion := 33000000;
  pais.superficie := 1285216;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Sol';
  pais.limitrofes := 'Ecuador,Colombia,Brasil,Bolivia,Chile';
  pais.independencia := '28 de julio de 1821';
  pais.comida_tipica := 'Ceviche, lomo saltado, aji de gallina';
  pais.punto_alto := 'Nevado Huascaran';
  pais.altura_max := 6768;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Ecuador';
  pais.capital := 'Quito';
  pais.continente := 'America del Sur';
  pais.poblacion := 17600000;
  pais.superficie := 283561;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Dolar estadounidense';
  pais.limitrofes := 'Colombia,Peru';
  pais.independencia := '24 de mayo de 1822';
  pais.comida_tipica := 'Ceviche, encebollado, hornado';
  pais.punto_alto := 'Chimborazo';
  pais.altura_max := 6263;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Bolivia';
  pais.capital := 'La Paz';
  pais.continente := 'America del Sur';
  pais.poblacion := 11700000;
  pais.superficie := 1098581;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Boliviano';
  pais.limitrofes := 'Peru,Brasil,Paraguay,Argentina,Chile';
  pais.independencia := '6 de agosto de 1825';
  pais.comida_tipica := 'Saltenias, pique macho, anticuchos';
  pais.punto_alto := 'Nevado Sajama';
  pais.altura_max := 6542;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Chile';
  pais.capital := 'Santiago';
  pais.continente := 'America del Sur';
  pais.poblacion := 19100000;
  pais.superficie := 756102;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso chileno';
  pais.limitrofes := 'Peru,Bolivia,Argentina';
  pais.independencia := '18 de septiembre de 1810';
  pais.comida_tipica := 'Empanadas, pastel de choclo, curanto';
  pais.punto_alto := 'Nevado Ojos del Salado';
  pais.altura_max := 6893;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Argentina';
  pais.capital := 'Buenos Aires';
  pais.continente := 'America del Sur';
  pais.poblacion := 45200000;
  pais.superficie := 2780400;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso argentino';
  pais.limitrofes := 'Chile,Bolivia,Paraguay,Brasil,Uruguay';
  pais.independencia := '9 de julio de 1816';
  pais.comida_tipica := 'Asado, empanadas, milanesas';
  pais.punto_alto := 'Aconcagua';
  pais.altura_max := 6961;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Uruguay';
  pais.capital := 'Montevideo';
  pais.continente := 'America del Sur';
  pais.poblacion := 3500000;
  pais.superficie := 176215;
  pais.idioma := 'Espaniol';
  pais.moneda := 'Peso uruguayo';
  pais.limitrofes := 'Brasil,Argentina';
  pais.independencia := '25 de agosto de 1825';
  pais.comida_tipica := 'Asado, chivito, tortas fritas';
  pais.punto_alto := 'Cerro Catedral';
  pais.altura_max := 514;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Paraguay';
  pais.capital := 'Asuncion';
  pais.continente := 'America del Sur';
  pais.poblacion := 7100000;
  pais.superficie := 406752;
  pais.idioma := 'Espaniol y Guarani';
  pais.moneda := 'Guarani';
  pais.limitrofes := 'Bolivia,Brasil,Argentina';
  pais.independencia := '15 de mayo de 1811';
  pais.comida_tipica := 'Sopa paraguaya, chipa, mbeju';
  pais.punto_alto := 'Cerro Pero';
  pais.altura_max := 842;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Guyana';
  pais.capital := 'Georgetown';
  pais.continente := 'America del Sur';
  pais.poblacion := 786000;
  pais.superficie := 214969;
  pais.idioma := 'Ingles';
  pais.moneda := 'Dolar guayanes';
  pais.limitrofes := 'Venezuela, Brasil, Surinam';
  pais.independencia := '26 de mayo de 1966 (del Reino Unido)';
  pais.comida_tipica := 'Pepperpot, roti, metemgee';
  pais.punto_alto := 'Monte Roraima';
  pais.altura_max := 2772;
  pais.activo := true;
  write(arch_paises, pais);

  pais.nombre := 'Surinam';
  pais.capital := 'Paramaribo';
  pais.continente := 'America del Sur';
  pais.poblacion := 587000;
  pais.superficie := 163820;
  pais.idioma := 'Holandes';
  pais.moneda := 'Dolar surinames';
  pais.limitrofes := 'Guyana, Brasil';
  pais.independencia := '25 de noviembre de 1975 (de Holanda)';
  pais.comida_tipica := 'Roti, pom, bami';
  pais.punto_alto := 'Julianatop';
  pais.altura_max := 1230;
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

               