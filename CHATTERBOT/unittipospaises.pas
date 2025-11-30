unit UnitTiposPaises;

interface

const
  MAX_PAISES = 50;
  ARCHIVO_PAISES = 'paises_america.dat';

type
  TPais = record
    nombre: string[50];
    capital: string[50];
    latitud: real;
    longitud: real;
    continente: string[20];  // America del Norte, America Central, America del Sur, Caribe
    poblacion: longint;
    idioma: string[30];
    moneda: string[30];
    activo: boolean;
  end;

  TArchivoPaises = file of TPais;

  TArregloPaises = array[1..MAX_PAISES] of TPais;

var
  paisesMemoria: TArregloPaises;
  cantidadPaises: integer;

implementation

initialization
  cantidadPaises := 0;

end.
