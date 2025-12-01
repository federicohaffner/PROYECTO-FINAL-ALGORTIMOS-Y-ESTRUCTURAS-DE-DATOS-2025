unit Respuestas_paises;

interface

uses
  crt,sysutils, Declaracion_paises, Busqueda_paises,  Palabras_paises, Utilidades_paises;

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
    Centrado('Por favor, especifica de que pais quieres saber la capital.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado('La capital de ' + pais.nombre + ' es ' + pais.capital + '.');
    end
    else
      Centrado('No encontre informacion sobre ese pais.');
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
    Centrado('De que pais quieres conocer la ubicacion?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado(pais.nombre + ' se encuentra en ' + pais.continente + '.');
    end
    else
      Centrado('No tengo informacion sobre ese pais.');
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
    Centrado('Sobre que pais te gustaria saber mas?');
    Centrado('Puedo contarte sobre cualquier pais de America.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado('-   Informacion sobre ' + pais.nombre + '   -');
      Centrado('Capital: ' + pais.capital);
      Centrado('Region: ' + pais.continente);
      Centrado('Poblacion: Aproximadamente ' + FormatearNumero(pais.poblacion) + ' habitantes');
      Centrado('Superficie: ' + FormatearNumero(pais.superficie) + ' km^2');
      Centrado('Idioma oficial: ' + pais.idioma);
      Centrado('Moneda: ' + pais.moneda);
    end
    else
      Centrado('No encontre informacion sobre ese pais.');
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
    Centrado('Tengo informacion sobre paises de:');
    Centrado('  - America del Norte (' + IntToStr(ContarPaisesPorRegion('America del Norte', vector, cantidad)) + ' paises)');
    Centrado('  - America Central (' + IntToStr(ContarPaisesPorRegion('America Central', vector, cantidad)) + ' paises)');
    Centrado('  - America del Sur (' + IntToStr(ContarPaisesPorRegion('America del Sur', vector, cantidad)) + ' paises)');
    Centrado('  - Caribe (' + IntToStr(ContarPaisesPorRegion('Caribe', vector, cantidad)) + ' paises)');
    Centrado('');
    Centrado('Total: ' + IntToStr(cantidad) + ' paises en mi base de datos.');
    Centrado('De que region quieres ver el listado completo?');
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
    Centrado('De que pais quieres saber la poblacion?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado(pais.nombre + ' tiene aproximadamente ' + FormatearNumero(pais.poblacion) + ' habitantes.');
      if pais.poblacion > 100000000 then
        Centrado('Es uno de los paises mas poblados de America!')
      else if pais.poblacion < 1000000 then
        Centrado('Es un pais con poca poblacion comparado con otros de America.')
      else if pais.poblacion > 50000000 then
        Centrado('Tiene una poblacion considerable en el continente.');
    end
    else
      Centrado('No tengo datos sobre ese pais.');
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
    Centrado('De que pais quieres saber el idioma?');
    Centrado('En America se hablan principalmente espaniol, ingles, portugues y frances.');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado('En ' + pais.nombre + ' se habla ' + pais.idioma + '.');

      if pos('Espaniol', pais.idioma) > 0 then
        Centrado('El espaniol es el idioma mas hablado en America Latina.')
      else if pos('Ingles', pais.idioma) > 0 then
        Centrado('El ingles es uno de los idiomas principales en America del Norte.')
      else if pos('Portugues', pais.idioma) > 0 then
        Centrado('Brasil es el unico pais de America donde se habla portugues.')
      else if pos('Frances', pais.idioma) > 0 then
        Centrado('El frances se habla en algunos paises del Caribe y Canada.');
    end
    else
      Centrado('No encontre informacion sobre ese pais.');
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
    Centrado('De que pais quieres conocer la moneda?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado('En ' + pais.nombre + ' se usa: ' + pais.moneda + '.');

      if pos('Dolar estadounidense', pais.moneda) > 0 then
        Centrado('Varios paises de America utilizan el dolar estadounidense como moneda principal.')
      else if pos('peso', lowercase(pais.moneda)) > 0 then
        Centrado('El peso es una moneda comun en varios paises de America.');
    end
    else
      Centrado('No tengo informacion sobre la moneda de ese pais.');
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
    Centrado('De que pais quieres saber la superficie?');
  end
  else
  begin
    pais := BuscarPais(nombrePais, vector, cantidad);
    if pais.activo then
    begin
      Centrado(pais.nombre + ' tiene una superficie de ' + FormatearNumero(pais.superficie) + ' km^2.');

      if pais.superficie < 5000 then
      begin
        Centrado('Clasificacion: MICRO-ESTADO.');

      end
      else if pais.superficie < 100000 then
      begin
        Centrado('Clasificacion: Pais PEQUENIO.');
      end
      else if pais.superficie < 1000000 then
      begin
        Centrado('Clasificacion: Pais MEDIANO.');
      end
      else if pais.superficie < 3000000 then
      begin
        Centrado('Clasificacion: Pais GRANDE.');
      end
      else
      begin
        Centrado('Clasificacion: Pais GIGANTE.');
      end;
    end
    else
      Centrado('No tengo informacion sobre ese pais.');
  end;
end;

procedure Respuesta_ayuda;
begin
  Centrado('Claro. Puedo ayudarte con informacion sobre los paises de America.');
  Centrado('');
  Centrado('Puedes preguntarme cosas como:');
  Centrado('  - "Cual es la capital de [pais]?"');
  Centrado('  - "Dime informacion sobre [pais]"');
  Centrado('  - "Donde queda [pais]?"');
  Centrado('  - "Cuantos habitantes tiene [pais]?"');
  Centrado('  - "Que idioma se habla en [pais]?"');
  Centrado('  - "Que moneda usan en [pais]?"');
  Centrado('  - "Cual es la superficie de [pais]?"');
  Centrado('  - "Muestra los paises de [region]"');
  Centrado('  - "Dame un dato curioso"');
  Centrado('');
  Centrado('Preguntame lo que quieras saber');
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
  Centrado(saludos[indice]);
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
        Centrado('Sabias que la capital de ' + pais.nombre + ' es ' + pais.capital + '?');
        Centrado('Esta ubicada en ' + pais.continente + '.');
      end;
      1: begin
        Centrado('Dato curioso: ' + pais.nombre + ' tiene aproximadamente ' + FormatearNumero(pais.poblacion) + ' habitantes y se habla ' + pais.idioma + '.');
      end;
      2: begin
        Centrado('Sabias que en ' + pais.nombre + ' se usa ' + pais.moneda + ' como moneda?');
      end;
      3: begin
        if pais.poblacion > 100000000 then
          Centrado(pais.nombre + ' se encuentra entre los paises mas poblados de America!');
      end;
      4: begin
        Centrado('Sabias que ' + pais.nombre + ' esta en ' + pais.continente + '?');
        Centrado('Su idioma oficial es ' + pais.idioma + '.');
      end;
    end;
  end
  else
    Centrado('No pude generar un dato curioso en este momento.');
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

    Centrado('-  Comparacion: ' + pais1.nombre + ' vs ' + pais2.nombre + '  -');
    Centrado('');
    Centrado('CAPITALES:');
    Centrado('  ' + pais1.nombre + ': ' + pais1.capital);
    Centrado('  ' + pais2.nombre + ': ' + pais2.capital);
    Centrado('');
    Centrado('POBLACION:');
    Centrado('  ' + pais1.nombre + ': ' + FormatearNumero(pais1.poblacion) + ' habitantes');
    Centrado('  ' + pais2.nombre + ': ' + FormatearNumero(pais2.poblacion) + ' habitantes');

    if pais1.poblacion > pais2.poblacion then
      Centrado(pais1.nombre + ' tiene mas poblacion')
    else
      Centrado(pais2.nombre + ' tiene mas poblacion');

    Centrado('');
    Centrado('IDIOMAS:');
    Centrado('  ' + pais1.nombre + ': ' + pais1.idioma);
    Centrado('  ' + pais2.nombre + ': ' + pais2.idioma);
    Centrado('');
    Centrado('MONEDAS:');
    Centrado('  ' + pais1.nombre + ': ' + pais1.moneda);
    Centrado('  ' + pais2.nombre + ': ' + pais2.moneda);
  end
  else
  begin
    Centrado('Para comparar necesito que menciones dos paises.');
    Centrado('Por ejemplo: "Compara Brasil y Argentina"');
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
      Centrado('');
      Centrado('Estadisticas de ' + region + ':');
      Centrado('  Total de paises: ' + IntToStr(contador));
      Centrado('  Poblacion total aproximada: ' + FormatearNumero(poblacionTotal) + ' habitantes');
    end;
  end
  else
  begin
    Centrado('No entendi que region quieres conocer.');
    Centrado('Las regiones disponibles son:');
    Centrado('  - America del Norte');
    Centrado('  - America Central');
    Centrado('  - America del Sur');
    Centrado('  - Caribe');
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
  Centrado(respuestas[indice]);
end;

end. 