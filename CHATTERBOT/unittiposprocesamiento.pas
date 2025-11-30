unit UnitTiposProcesamiento;

interface

type
  TTipoConsulta = (
    tcCapital,
    tcUbicacion,
    tcInformacion,
    tcListado,
    tcComparacion,
    tcPoblacion,
    tcIdioma,
    tcMoneda,
    tcAyuda,
    tcDesconocida,
    tcSaludo,
    tcCuriosos,
    tcRegion
  );

  TRespuesta = record
    tipo: TTipoConsulta;
    mensaje: string;
    exitoso: boolean;
  end;

implementation

end.
