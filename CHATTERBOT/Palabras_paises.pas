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
  resultado: TTipoConsulta;
  encontrado: boolean;
begin
  entrada := lowercase(entrada);
  encontrado := false;
  resultado := tcDesconocida;

  if not encontrado then
  begin
    if (pos('hola', entrada) > 0) or
       (pos('buenos dias', entrada) > 0) or
       (pos('buenas tardes', entrada) > 0) or
       (pos('buenas noches', entrada) > 0) or
       (pos('que tal', entrada) > 0) then
    begin
      resultado := tcSaludo;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('capital', entrada) > 0) or
       (pos('cual es la capital', entrada) > 0) then
    begin
      resultado := tcCapital;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('donde queda', entrada) > 0) or
       (pos('donde esta', entrada) > 0) or
       (pos('ubicacion', entrada) > 0) then
    begin
      resultado := tcUbicacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('poblacion', entrada) > 0) or
       (pos('habitantes', entrada) > 0) or
       (pos('cuantas personas', entrada) > 0) or
       (pos('cuanta gente', entrada) > 0) then
    begin
      resultado := tcPoblacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('idioma', entrada) > 0) or
       (pos('que se habla', entrada) > 0) or
       (pos('lengua', entrada) > 0) or
       (pos('hablan', entrada) > 0) then
    begin
      resultado := tcIdioma;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('moneda', entrada) > 0) or
       (pos('dinero', entrada) > 0) or
       (pos('divisa', entrada) > 0) or
       (pos('que se usa para pagar', entrada) > 0) then
    begin
      resultado := tcMoneda;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('superficie', entrada) > 0) or
       (pos('area', entrada) > 0) or
       (pos('tamanio', entrada) > 0) or
       (pos('extension', entrada) > 0) then
    begin
      resultado := tcSuperficie;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('limitrofe', entrada) > 0) or
       (pos('frontera', entrada) > 0) or
       (pos('limita con', entrada) > 0) or
       (pos('paises vecinos', entrada) > 0) or
       (pos('con quien limita', entrada) > 0) then
    begin
      resultado := tcLimitrofes;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('independencia', entrada) > 0) or
       (pos('cuando se independizo', entrada) > 0) or
       (pos('fecha de independencia', entrada) > 0) or
       (pos('se independizo', entrada) > 0) then
    begin
      resultado := tcIndependencia;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('comida', entrada) > 0) or
       (pos('plato', entrada) > 0) or
       (pos('gastronomia', entrada) > 0) or
       (pos('comida tipica', entrada) > 0) or
       (pos('que se come', entrada) > 0) then
    begin
      resultado := tcComida;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('punto mas alto', entrada) > 0) or
       (pos('montana', entrada) > 0) or
       (pos('pico', entrada) > 0) or
       (pos('cerro', entrada) > 0) or
       (pos('altura', entrada) > 0) or
       (pos('elevacion', entrada) > 0) then
    begin
      resultado := tcPuntoAlto;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('lista', entrada) > 0) or
       (pos('muestra', entrada) > 0) or
       (pos('cuales son', entrada) > 0) or
       (pos('todos los paises', entrada) > 0) then
    begin
      resultado := tcListado;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('america del norte', entrada) > 0) or
       (pos('america del sur', entrada) > 0) or
       (pos('america central', entrada) > 0) or
       (pos('sudamerica', entrada) > 0) or
       (pos('norteamerica', entrada) > 0) or
       (pos('centroamerica', entrada) > 0) or
       (pos('caribe', entrada) > 0) then
    begin
      resultado := tcRegion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('compara', entrada) > 0) or
       (pos('diferencia', entrada) > 0) or
       (pos('versus', entrada) > 0) or
       (pos(' vs ', entrada) > 0) then
    begin
      resultado := tcComparacion;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('dato curioso', entrada) > 0) or
       (pos('curiosidad', entrada) > 0) or
       (pos('aleatorio', entrada) > 0) or
       (pos('cuentame algo', entrada) > 0) then
    begin
      resultado := tcCuriosos;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('ayuda', entrada) > 0) or
       (pos('help', entrada) > 0) or
       (pos('que puedes hacer', entrada) > 0) or
       (pos('como funciona', entrada) > 0) then
    begin
      resultado := tcAyuda;
      encontrado := true;
    end;
  end;

  if not encontrado then
  begin
    if (pos('dime sobre', entrada) > 0) or
       (pos('habla sobre', entrada) > 0) or
       (pos('informacion', entrada) > 0) or
       (pos('cuentame', entrada) > 0) or
       (pos('que sabes de', entrada) > 0) then
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

  nombrePais: string;
  encontrado: boolean;
begin
  entrada := lowercase(entrada);
  ExtraerNombrePais := '';
  encontrado := false;
  i := 1;

  while (i <= cantidad) and (not encontrado) do
  begin
    nombrePais := lowercase(vector[i].nombre);
    if pos(nombrePais, entrada) > 0 then
    begin
      ExtraerNombrePais := vector[i].nombre;
      encontrado := true;
    end
    else
      inc(i);
  end;
end;

function ExtraerRegion(entrada: string): string;
begin
  entrada := lowercase(entrada);
  ExtraerRegion := '';

  if (pos('america del norte', entrada) > 0) or
     (pos('norteamerica', entrada) > 0) or
     (pos('norte america', entrada) > 0) then
    ExtraerRegion := 'America del Norte'

  else if (pos('america del sur', entrada) > 0) or
          (pos('sudamerica', entrada) > 0) or
          (pos('sur america', entrada) > 0) or
          (pos('suramerica', entrada) > 0) then
    ExtraerRegion := 'America del Sur'

  else if (pos('america central', entrada) > 0) or
          (pos('centroamerica', entrada) > 0) or
          (pos('centro america', entrada) > 0) then
    ExtraerRegion := 'America Central'

  else if (pos('caribe', entrada) > 0) or
          (pos('antillas', entrada) > 0) or
          (pos('islas del caribe', entrada) > 0) then
    ExtraerRegion := 'Caribe';
end;

function ExtraerDosPaises(entrada: string; var pais1, pais2: string; vector: t_vector_pais; cantidad: integer): boolean;
var
  i: integer;
  encontrado1, encontrado2: boolean;
begin
  entrada := lowercase(entrada);
  pais1 := '';
  pais2 := '';
  encontrado1 := false;
  encontrado2 := false;
  i := 1;

  while (i <= cantidad) and (not encontrado2) do
  begin
    if pos(lowercase(vector[i].nombre), entrada) > 0 then
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

