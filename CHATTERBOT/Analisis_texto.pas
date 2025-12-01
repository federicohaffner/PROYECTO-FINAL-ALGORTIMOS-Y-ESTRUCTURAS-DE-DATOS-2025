unit Palabras_paises;

interface

uses
  sysutils, Busqueda_paises, Declaracion_paises;

function DeterminarTipoConsulta(entrada: string; vector: t_vector_pais; cantidad: integer): TTipoConsulta;
function ExtraerNombrePais(entrada: string; vector: t_vector_pais; cantidad: integer): string;
function ExtraerRegion(entrada: string): string;
function ExtraerDosPaises(entrada: string; var pais1, pais2: string; vector: t_vector_pais; cantidad: integer): boolean;

implementation
function DeterminarTipoConsulta(entrada: string; vector: t_vector_pais; cantidad: integer): TTipoConsulta;
var
  entradaMin: string;
  resultado: TTipoConsulta;
  encontrado: boolean;
begin
  entradaMin := lowercase(entrada);
  encontrado := false;
  resultado := tcDesconocida;

  if not encontrado then
  begin
    if (pos('hola', entradaMin) > 0) or
       (pos('buenos dias', entradaMin) > 0) or
       (pos('buenas tardes', entradaMin) > 0) or
       (pos('buenas noches', entradaMin) > 0) or
       (pos('que tal', entradaMin) > 0) then
    begin
      resultado := tcSaludo;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('capital', entradaMin) > 0) or
       (pos('cual es la capital', entradaMin) > 0) then
    begin
      resultado := tcCapital;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('donde queda', entradaMin) > 0) or
       (pos('donde esta', entradaMin) > 0) or
       (pos('ubicacion', entradaMin) > 0) then
    begin
      resultado := tcUbicacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('poblacion', entradaMin) > 0) or
       (pos('habitantes', entradaMin) > 0) or
       (pos('cuantas personas', entradaMin) > 0) or
       (pos('cuanta gente', entradaMin) > 0) then
    begin
      resultado := tcPoblacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('idioma', entradaMin) > 0) or
       (pos('que se habla', entradaMin) > 0) or
       (pos('lengua', entradaMin) > 0) or
       (pos('hablan', entradaMin) > 0) then
    begin
      resultado := tcIdioma;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('moneda', entradaMin) > 0) or
       (pos('dinero', entradaMin) > 0) or
       (pos('divisa', entradaMin) > 0) or
       (pos('que se usa para pagar', entradaMin) > 0) then
    begin
      resultado := tcMoneda;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('superficie', entradaMin) > 0) or
       (pos('area', entradaMin) > 0) or
       (pos('tamanio', entradaMin) > 0) or
       (pos('extension', entradaMin) > 0) then
    begin
      resultado := tcSuperficie;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('lista', entradaMin) > 0) or
       (pos('muestra', entradaMin) > 0) or
       (pos('cuales son', entradaMin) > 0) or
       (pos('todos los paises', entradaMin) > 0) then
    begin
      resultado := tcListado;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('america del norte', entradaMin) > 0) or
       (pos('america del sur', entradaMin) > 0) or
       (pos('america central', entradaMin) > 0) or
       (pos('sudamerica', entradaMin) > 0) or
       (pos('norteamerica', entradaMin) > 0) or
       (pos('centroamerica', entradaMin) > 0) or
       (pos('caribe', entradaMin) > 0) then
    begin
      resultado := tcRegion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('compara', entradaMin) > 0) or
       (pos('diferencia', entradaMin) > 0) or
       (pos('versus', entradaMin) > 0) or
       (pos(' vs ', entradaMin) > 0) then
    begin
      resultado := tcComparacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('dato curioso', entradaMin) > 0) or
       (pos('curiosidad', entradaMin) > 0) or
       (pos('aleatorio', entradaMin) > 0) or
       (pos('cuentame algo', entradaMin) > 0) then
    begin
      resultado := tcCuriosos;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('ayuda', entradaMin) > 0) or
       (pos('help', entradaMin) > 0) or
       (pos('que puedes hacer', entradaMin) > 0) or
       (pos('como funciona', entradaMin) > 0) then
    begin
      resultado := tcAyuda;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('dime sobre', entradaMin) > 0) or
       (pos('habla sobre', entradaMin) > 0) or
       (pos('informacion', entradaMin) > 0) or
       (pos('cuentame', entradaMin) > 0) or
       (pos('que sabes de', entradaMin) > 0) then
    begin
      resultado := tcInformacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if ExtraerNombrePais(entrada, vector, cantidad) <> '' then
    begin
      resultado := tcInformacion;
      encontrado := true;
    end;
  end;

  DeterminarTipoConsulta := resultado;
end;

function ExtraerNombrePais(entrada: string; vector: t_vector_pais; cantidad: integer): string;
var
  i: integer;
  entradaMin: string;
  nombrePais: string;
  encontrado: boolean;
begin
  entradaMin := lowercase(entrada);
  ExtraerNombrePais := '';
  encontrado := false;
  i := 1;

  while (i <= cantidad) and (not encontrado) do
  begin
    nombrePais := lowercase(vector[i].nombre);
    if pos(nombrePais, entradaMin) > 0 then
    begin
      ExtraerNombrePais := vector[i].nombre;
      encontrado := true;
    end
    else
      inc(i);
  end;
end;

function ExtraerRegion(entrada: string): string;
var
  entradaMin: string;
begin
  entradaMin := lowercase(entrada);
  ExtraerRegion := '';

  if (pos('america del norte', entradaMin) > 0) or
     (pos('norteamerica', entradaMin) > 0) or
     (pos('norte america', entradaMin) > 0) then
    ExtraerRegion := 'America del Norte'

  else if (pos('america del sur', entradaMin) > 0) or
          (pos('sudamerica', entradaMin) > 0) or
          (pos('sur america', entradaMin) > 0) or
          (pos('suramerica', entradaMin) > 0) then
    ExtraerRegion := 'America del Sur'

  else if (pos('america central', entradaMin) > 0) or
          (pos('centroamerica', entradaMin) > 0) or
          (pos('centro america', entradaMin) > 0) then
    ExtraerRegion := 'America Central'

  else if (pos('caribe', entradaMin) > 0) or
          (pos('antillas', entradaMin) > 0) or
          (pos('islas del caribe', entradaMin) > 0) then
    ExtraerRegion := 'Caribe';
end;

function ExtraerDosPaises(entrada: string; var pais1, pais2: string; vector: t_vector_pais; cantidad: integer): boolean;
var
  i: integer;
  entradaMin: string;
  encontrado1, encontrado2: boolean;
begin
  entradaMin := lowercase(entrada);
  pais1 := '';
  pais2 := '';
  encontrado1 := false;
  encontrado2 := false;
  i := 1;

  while (i <= cantidad) and (not encontrado2) do
  begin
    if pos(lowercase(vector[i].nombre), entradaMin) > 0 then
    begin
      if not encontrado1 then
      begin
        pais1 := vector[i].nombre;
        encontrado1 := true;
      end
      else if not encontrado2 then
      begin
        pais2 := vector[i].nombre;
        encontrado2 := true;
      end;
    end;
    inc(i);
  end;

  ExtraerDosPaises := encontrado1 and encontrado2;
end;

end. 

