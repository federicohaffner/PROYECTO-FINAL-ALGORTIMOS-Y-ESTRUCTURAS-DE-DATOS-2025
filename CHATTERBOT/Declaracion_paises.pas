unit Declaracion_paises;

interface

const
  paises_max = 50;
  arch_paises = 'paises.dat';

type
  t_dato_pais = record
    nombre: string[50];
    capital: string[50];
    superficie: longint;
    continente: string[20];
    poblacion: longint;
    limitrofes: string[100];
    independencia: string[60];     
    comida_tipica: string[80];     
    punto_alto: string[50];        
    altura_max: integer;          
    idioma: string[30];
    moneda: string[30];
    activo: boolean;
  end;

  t_arch_paises = file of t_dato_pais;
  t_vector_pais = array[1..paises_max] of t_dato_pais;

 TTipoConsulta = (tcCapital, tcUbicacion, tcInformacion, tcListado, 
                   tcComparacion, tcPoblacion, tcIdioma, tcMoneda, 
                   tcSuperficie, tcLimitrofes, tcIndependencia, 
                   tcComida, tcPuntoAlto, tcAyuda, tcDesconocida, 
                   tcSaludo, tcCuriosos, tcRegion);
                                    
implementation

end.                                       