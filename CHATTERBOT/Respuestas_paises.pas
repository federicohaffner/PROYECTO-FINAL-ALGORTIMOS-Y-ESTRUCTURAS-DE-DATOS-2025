unit Respuestas_paises;

interface

uses
  sysutils, Declaracion_paises, Busqueda_paises,  Palabras_paises, Utilidades_paises;

procedure ProcesarYResponder(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_capital(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_ubicacion(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_informacion(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_listado(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_poblacion(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_idioma(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_moneda(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_superficie(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_ayuda;
procedure Respuesta_saludo;
procedure Respuesta_dato_curioso(vector: t_vector_pais; cantidad: integer);
procedure Respuesta_comparacion(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_region(entrada: string; vector: t_vector_pais; cantidad: integer);
procedure Respuesta_desconocida;

implementation

procedure ProcesarYResponder(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  tipo: TTipoConsulta;
begin
  tipo := DeterminarTipoConsulta(entrada, vector, cantidad);

  case tipo of
    tcCapital: Respuesta_capital(entrada, vector, cantidad);
    tcUbicacion: Respuesta_ubicacion(entrada, vector, cantidad);
    tcInformacion: Respuesta_informacion(entrada, vector, cantidad);
    tcListado: Respuesta_listado(entrada, vector, cantidad);
    tcPoblacion: Respuesta_poblacion(entrada, vector, cantidad);
    tcIdioma: Respuesta_idioma(entrada, vector, cantidad);
    tcMoneda: Respuesta_moneda(entrada, vector, cantidad);
    tcSuperficie: Respuesta_superficie(entrada, vector, cantidad);
    tcComparacion: Respuesta_comparacion(entrada, vector, cantidad);
    tcRegion: Respuesta_region(entrada, vector, cantidad);
    tcAyuda: Respuesta_ayuda;
    tcSaludo: Respuesta_saludo;
    tcCuriosos: Respuesta_dato_curioso(vector, cantidad);
    tcDesconocida: Respuesta_desconocida;
  end;
end;

procedure Respuesta_capital(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('Por favor, especifica de que pais quieres saber la capital.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln('La capital de ', pais.nombre, ' es ', pais.capital, '.');
    end
    else
      writeln('No encontre informacion sobre ese pais.');
  end;
end;

procedure Respuesta_ubicacion(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('De que pais quieres conocer la ubicacion?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln(pais.nombre, ' se encuentra en ', pais.continente, '.');
    end
    else
      writeln('No tengo informacion sobre ese pais.');
  end;
end;

procedure Respuesta_informacion(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('Sobre que pais te gustaria saber mas?');
    writeln('Puedo contarte sobre cualquier pais de America.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln('-   Informacion sobre ', pais.nombre, '   -');
      writeln('Capital: ', pais.capital);
      writeln('Region: ', pais.continente);
      writeln('Poblacion: Aproximadamente ', FormatearNumero(pais.poblacion), ' habitantes');
      writeln('Superficie: ', FormatearNumero(pais.superficie), ' km²');
      writeln('Idioma oficial: ', pais.idioma);
      writeln('Moneda: ', pais.moneda);
    end
    else
      writeln('No encontre informacion sobre ese pais.');
  end;
end;

procedure Respuesta_listado(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  region: string;
begin
  region := ExtraerRegion(entrada);

  if region <> '' then
  begin
    ListarPaisesPorRegion(region, vector, cantidad);
  end
  else
  begin
    writeln('Tengo informacion sobre paises de:');
    writeln('  - America del Norte (', ContarPaisesPorRegion('America del Norte', vector, cantidad), ' paises)');
    writeln('  - America Central (', ContarPaisesPorRegion('America Central', vector, cantidad), ' paises)');
    writeln('  - America del Sur (', ContarPaisesPorRegion('America del Sur', vector, cantidad), ' paises)');
    writeln('  - Caribe (', ContarPaisesPorRegion('Caribe', vector, cantidad), ' paises)');
    writeln;
    writeln('Total: ', cantidad, ' paises en mi base de datos.');
    writeln('De que region quieres ver el listado completo?');
  end;
end;

procedure Respuesta_poblacion(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('De que pais quieres saber la poblacion?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln(pais.nombre, ' tiene aproximadamente ', FormatearNumero(pais.poblacion), ' habitantes.');
      if pais.poblacion > 100000000 then
        writeln('Es uno de los paises mas poblados de America!')
      else if pais.poblacion < 1000000 then
        writeln('Es un pais con poca poblacion comparado con otros de America.')
      else if pais.poblacion > 50000000 then
        writeln('Tiene una poblacion considerable en el continente.');
    end
    else
      writeln('No tengo datos sobre ese pais.');
  end;
end;

procedure Respuesta_idioma(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('De que pais quieres saber el idioma?');
    writeln('En America se hablan principalmente español, ingles, portugues y frances.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln('En ', pais.nombre, ' se habla ', pais.idioma, '.');

      if pos('Español', pais.idioma) > 0 then
        writeln('El español es el idioma mas hablado en America Latina.')
      else if pos('Ingles', pais.idioma) > 0 then
        writeln('El ingles es uno de los idiomas principales en America del Norte.')
      else if pos('Portugues', pais.idioma) > 0 then
        writeln('Brasil es el unico pais de America donde se habla portugues.')
      else if pos('Frances', pais.idioma) > 0 then
        writeln('El frances se habla en algunos paises del Caribe y Canada.');
    end
    else
      writeln('No encontre informacion sobre ese pais.');
  end;
end;

procedure Respuesta_moneda(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('De que pais quieres conocer la moneda?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln('En ', pais.nombre, ' se usa: ', pais.moneda, '.');

      if pos('Dolar estadounidense', pais.moneda) > 0 then
        writeln('Varios paises de America utilizan el dolar estadounidense como moneda principal.')
      else if pos('peso', lowercase(pais.moneda)) > 0 then
        writeln('El peso es una moneda comun en varios paises de America.');
    end
    else
      writeln('No tengo informacion sobre la moneda de ese pais.');
  end;
end;

procedure Respuesta_superficie(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  nombrePais: string;
  pais: t_dato_pais;
begin
  nombrePais := ExtraerNombrePais(entrada, vector, cantidad);

  if nombrePais = '' then
  begin
    writeln('De que pais quieres saber la superficie?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      writeln(pais.nombre, ' tiene una superficie de ', FormatearNumero(pais.superficie), ' km².');

      if pais.superficie < 5000 then
      begin
        writeln('Clasificacion: MICRO-ESTADO.');
        writeln('Es considerado un pais diminuto.');
      end
      else if pais.superficie < 100000 then
      begin
        writeln('Clasificacion: Pais PEQUEÑO.');
        writeln('Es considerado un pais pequeño.');
      end
      else if pais.superficie < 1000000 then
      begin
        writeln('Clasificacion: Pais MEDIANO.');
        writeln('Tiene un territorio bastante extenso.');
      end
      else if pais.superficie < 3000000 then
      begin
        writeln('Clasificacion: Pais GRANDE.');
        writeln('Es uno de los paises mas grandes de America.');
      end
      else
      begin
        writeln('Clasificacion: Pais GIGANTE.');
        writeln('Es uno de los paises mas grandes del mundo.');
      end;
    end
    else
      writeln('No tengo informacion sobre ese pais.');
  end;
end;

procedure Respuesta_ayuda;
begin
  writeln('Claro. Puedo ayudarte con informacion sobre los paises de America.');
  writeln;
  writeln('Puedes preguntarme cosas como:');
  writeln('  - "Cual es la capital de [pais]?"');
  writeln('  - "Dime informacion sobre [pais]"');
  writeln('  - "Donde queda [pais]?"');
  writeln('  - "Cuantos habitantes tiene [pais]?"');
  writeln('  - "Que idioma se habla en [pais]?"');
  writeln('  - "Que moneda usan en [pais]?"');
  writeln('  - "Cual es la superficie de [pais]?"');
  writeln('  - "Muestra los paises de [region]"');
  writeln('  - "Dame un dato curioso"');
  writeln;
  writeln('Preguntame lo que quieras saber');
end;

procedure Respuesta_saludo;
var
  saludos: array[1..3] of string;
  indice: integer;
begin
  saludos[1] := 'Hola. En que puedo ayudarte hoy?';
  saludos[2] := 'Saludos. Estoy aqui para responder tus preguntas sobre America.';
  saludos[3] := 'Bienvenido. Que te gustaria saber sobre los paises americanos?';

  indice := random(3) + 1;
  writeln(saludos[indice]);
end;

procedure Respuesta_dato_curioso(vector: t_vector_pais; cantidad: integer);
var
  pais: t_dato_pais;
  opcion: integer;
begin
  pais := ObtenerPaisAleatorio(vector, cantidad);

  if pais.activo then
  begin
    opcion := random(5);

    case opcion of
      0: begin
        writeln('Sabias que la capital de ', pais.nombre, ' es ', pais.capital, '?');
        writeln('Esta ubicada en ', pais.continente, '.');
      end;
      1: begin
        writeln('Dato curioso: ', pais.nombre, ' tiene aproximadamente ', FormatearNumero(pais.poblacion), ' habitantes y se habla ', pais.idioma, '.');
      end;
      2: begin
        writeln('Sabias que en ', pais.nombre, ' se usa ', pais.moneda, ' como moneda?');
      end;
      3: begin
        if pais.poblacion > 100000000 then
          writeln(pais.nombre, ' se encuentra entre los paises mas poblados de America!');
      end;
      4: begin
        writeln('Sabias que ', pais.nombre, ' esta en ', pais.continente, '?');
        writeln('Su idioma oficial es ', pais.idioma, '.');
      end;
    end;
  end
  else
    writeln('No pude generar un dato curioso en este momento.');
end;

procedure Respuesta_comparacion(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  pais1, pais2: t_dato_pais;
  nombre1, nombre2: string;
begin
  if ExtraerDosPaises(entrada, nombre1, nombre2, vector, cantidad) then
  begin
    pais1 := BuscarPais(nombre1, vector, cantidad);
    pais2 := BuscarPais(nombre2, vector, cantidad);

    writeln('-  Comparacion: ', pais1.nombre, ' vs ', pais2.nombre, '  -');
    writeln;
    writeln('CAPITALES:');
    writeln('  ', pais1.nombre, ': ', pais1.capital);
    writeln('  ', pais2.nombre, ': ', pais2.capital);
    writeln;
    writeln('POBLACION:');
    writeln('  ', pais1.nombre, ': ', FormatearNumero(pais1.poblacion), ' habitantes');
    writeln('  ', pais2.nombre, ': ', FormatearNumero(pais2.poblacion), ' habitantes');

    if pais1.poblacion > pais2.poblacion then
      writeln(pais1.nombre, ' tiene mas poblacion')
    else
      writeln(pais2.nombre, ' tiene mas poblacion');

    writeln;
    writeln('IDIOMAS:');
    writeln('  ', pais1.nombre, ': ', pais1.idioma);
    writeln('  ', pais2.nombre, ': ', pais2.idioma);
    writeln;
    writeln('MONEDAS:');
    writeln('  ', pais1.nombre, ': ', pais1.moneda);
    writeln('  ', pais2.nombre, ': ', pais2.moneda);
  end
  else
  begin
    writeln('Para comparar necesito que menciones dos paises.');
    writeln('Por ejemplo: "Compara Brasil y Argentina"');
  end;
end;

procedure Respuesta_region(entrada: string; vector: t_vector_pais; cantidad: integer);
var
  region: string;
  i, contador: integer;
  poblacionTotal: longint;
begin
  region := ExtraerRegion(entrada);

  if region <> '' then
  begin
    ListarPaisesPorRegion(region, vector, cantidad);

    contador := 0;
    poblacionTotal := 0;
    for i := 1 to cantidad do
    begin
      if lowercase(vector[i].continente) = lowercase(region) then
      begin
        inc(contador);
        poblacionTotal := poblacionTotal + vector[i].poblacion;
      end;
    end;

    if contador > 0 then
    begin
      writeln;
      writeln('Estadisticas de ', region, ':');
      writeln('  Total de paises: ', contador);
      writeln('  Poblacion total aproximada: ', FormatearNumero(poblacionTotal), ' habitantes');
    end;
  end
  else
  begin
    writeln('No entendi que region quieres conocer.');
    writeln('Las regiones disponibles son:');
    writeln('  - America del Norte');
    writeln('  - America Central');
    writeln('  - America del Sur');
    writeln('  - Caribe');
  end;
end;

procedure Respuesta_desconocida;
var
  respuestas: array[1..3] of string;
  indice: integer;
begin
  respuestas[1] := 'No entendi tu pregunta. Podrias reformularla?';
  respuestas[2] := 'Disculpa, no comprendi. Intenta preguntarme sobre un pais especifico.';
  respuestas[3] := 'Lo siento, no entiendo. Escribe "ayuda" para ver que puedo hacer.';

  indice := random(3) + 1;
  writeln(respuestas[indice]);
end;

end.