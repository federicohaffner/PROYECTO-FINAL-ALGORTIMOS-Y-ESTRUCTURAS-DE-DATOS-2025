unit UPaisesData;

interface

type
  TPais = record
    Nombre: string[50];
    Capital: string[50];
    Superficie: LongInt; 
    Poblacion: LongInt;  
  end;

var
  pais: array[1..35] of TPais;

procedure CargarPaises;

function BuscarIndicePais(nombreBusqueda: string): integer;

implementation

uses SysUtils;

function BuscarIndicePais(nombreBusqueda: string): integer;
var
  i: integer;
  encontrado: integer;
begin
  encontrado := 0;
  for i := 1 to 35 do
  begin
    if LowerCase(pais[i].Nombre) = LowerCase(nombreBusqueda) then
    begin
      encontrado := i;
      Break; 
    end;
  end;
  BuscarIndicePais := encontrado;
end;

procedure CargarPaises;
begin
  { --- NORTEAMERICA --- }
  pais[1].Nombre := 'Canada';
  pais[1].Capital := 'Ottawa';
  pais[1].Superficie := 9984670;
  pais[1].Poblacion := 38900000;

  pais[2].Nombre := 'Estados Unidos';
  pais[2].Capital := 'Washington D.C.';
  pais[2].Superficie := 9833520;
  pais[2].Poblacion := 333200000;

  pais[3].Nombre := 'Mexico';
  pais[3].Capital := 'Ciudad de Mexico';
  pais[3].Superficie := 1964375;
  pais[3].Poblacion := 127500000;

  { --- CENTROAMERICA --- }
  pais[4].Nombre := 'Belice';
  pais[4].Capital := 'Belmopan';
  pais[4].Superficie := 22966;
  pais[4].Poblacion := 397000;

  pais[5].Nombre := 'Costa Rica';
  pais[5].Capital := 'San Jose';
  pais[5].Superficie := 51100;
  pais[5].Poblacion := 5200000;

  pais[6].Nombre := 'El Salvador';
  pais[6].Capital := 'San Salvador';
  pais[6].Superficie := 21041;
  pais[6].Poblacion := 6300000;

  pais[7].Nombre := 'Guatemala';
  pais[7].Capital := 'Ciudad de Guatemala';
  pais[7].Superficie := 108889;
  pais[7].Poblacion := 17600000;

  pais[8].Nombre := 'Honduras';
  pais[8].Capital := 'Tegucigalpa';
  pais[8].Superficie := 112492;
  pais[8].Poblacion := 10400000;

  pais[9].Nombre := 'Nicaragua';
  pais[9].Capital := 'Managua';
  pais[9].Superficie := 130370;
  pais[9].Poblacion := 6800000;

  pais[10].Nombre := 'Panama';
  pais[10].Capital := 'Ciudad de Panama';
  pais[10].Superficie := 75420;
  pais[10].Poblacion := 4400000;

  { --- SUDAMERICA --- }
  pais[11].Nombre := 'Argentina';
  pais[11].Capital := 'Buenos Aires';
  pais[11].Superficie := 2780400;
  pais[11].Poblacion := 46200000;

  pais[12].Nombre := 'Bolivia';
  pais[12].Capital := 'Sucre';
  pais[12].Superficie := 1098581;
  pais[12].Poblacion := 12200000;

  pais[13].Nombre := 'Brasil';
  pais[13].Capital := 'Brasilia';
  pais[13].Superficie := 8515767;
  pais[13].Poblacion := 215300000;

  pais[14].Nombre := 'Chile';
  pais[14].Capital := 'Santiago';
  pais[14].Superficie := 756102;
  pais[14].Poblacion := 19600000;

  pais[15].Nombre := 'Colombia';
  pais[15].Capital := 'Bogota';
  pais[15].Superficie := 1141748;
  pais[15].Poblacion := 51800000;

  pais[16].Nombre := 'Ecuador';
  pais[16].Capital := 'Quito';
  pais[16].Superficie := 283561;
  pais[16].Poblacion := 18000000;

  pais[17].Nombre := 'Guyana';
  pais[17].Capital := 'Georgetown';
  pais[17].Superficie := 214969;
  pais[17].Poblacion := 808000;

  pais[18].Nombre := 'Paraguay';
  pais[18].Capital := 'Asuncion';
  pais[18].Superficie := 406752;
  pais[18].Poblacion := 7400000;

  pais[19].Nombre := 'Peru';
  pais[19].Capital := 'Lima';
  pais[19].Superficie := 1285216;
  pais[19].Poblacion := 34000000;

  pais[20].Nombre := 'Surinam';
  pais[20].Capital := 'Paramaribo';
  pais[20].Superficie := 163820;
  pais[20].Poblacion := 618000;

  pais[21].Nombre := 'Uruguay';
  pais[21].Capital := 'Montevideo';
  pais[21].Superficie := 176215;
  pais[21].Poblacion := 3400000;

  pais[22].Nombre := 'Venezuela';
  pais[22].Capital := 'Caracas';
  pais[22].Superficie := 916445;
  pais[22].Poblacion := 28300000;

  { --- CARIBE --- }
  pais[23].Nombre := 'Antigua y Barbuda';
  pais[23].Capital := 'Saint Johns';
  pais[23].Superficie := 442;
  pais[23].Poblacion := 97000;

  pais[24].Nombre := 'Bahamas';
  pais[24].Capital := 'Nasau';
  pais[24].Superficie := 13880;
  pais[24].Poblacion := 393000;

  pais[25].Nombre := 'Barbados';
  pais[25].Capital := 'Bridgetown';
  pais[25].Superficie := 430;
  pais[25].Poblacion := 287000;

  pais[26].Nombre := 'Cuba';
  pais[26].Capital := 'La Habana';
  pais[26].Superficie := 109884;
  pais[26].Poblacion := 11200000;

  pais[27].Nombre := 'Dominica';
  pais[27].Capital := 'Roseau';
  pais[27].Superficie := 751;
  pais[27].Poblacion := 72000;

  pais[28].Nombre := 'Granada';
  pais[28].Capital := 'Saint George';
  pais[28].Superficie := 344;
  pais[28].Poblacion := 113000;

  pais[29].Nombre := 'Haiti';
  pais[29].Capital := 'Puerto Principe';
  pais[29].Superficie := 27750;
  pais[29].Poblacion := 11500000;

  pais[30].Nombre := 'Jamaica';
  pais[30].Capital := 'Kingston';
  pais[30].Superficie := 10991;
  pais[30].Poblacion := 2800000;

  pais[31].Nombre := 'Republica Dominicana';
  pais[31].Capital := 'Santo Domingo';
  pais[31].Superficie := 48670;
  pais[31].Poblacion := 11200000;

  pais[32].Nombre := 'San Cristobal y Nieves';
  pais[32].Capital := 'Basseterre';
  pais[32].Superficie := 261;
  pais[32].Poblacion := 53000;

  pais[33].Nombre := 'San Vicente y las Granadinas';
  pais[33].Capital := 'Kingstown';
  pais[33].Superficie := 389;
  pais[33].Poblacion := 110000;

  pais[34].Nombre := 'Santa Lucia';
  pais[34].Capital := 'Castries';
  pais[34].Superficie := 616;
  pais[34].Poblacion := 183000;

  pais[35].Nombre := 'Trinidad y Tobago';
  pais[35].Capital := 'Puerto España';
  pais[35].Superficie := 5130;
  pais[35].Poblacion := 1400000;
end;

end.