# Proyecto Final · Algoritmos y Estructuras de Datos 2025

![Pascal](https://img.shields.io/badge/Lenguaje-Pascal-blue)
![Free Pascal](https://img.shields.io/badge/Compilador-Free%20Pascal%203.x-orange)
![Estado](https://img.shields.io/badge/Estado-Finalizado-brightgreen)

Trabajo práctico final de la materia **Algoritmos y Estructuras de Datos** (2025). Son **dos programas de consola** escritos en Pascal (Free Pascal) con interfaz en modo texto (unit `Crt`):

1. **Sistema de Gestión Educativa:** seguimiento del aprendizaje de alumnos con dificultades específicas, con datos persistidos en archivos binarios e índices en árboles binarios de búsqueda.
2. **GeoBot (Chatterbot):** un asistente conversacional que responde preguntas en lenguaje natural sobre los países de América.

---

## 👥 Autores

| Integrante | GitHub |
|---|---|
| **Federico Haffner** | [@federicohaffner](https://github.com/federicohaffner) |
| **Valentino Gussalli** | [@valentinogussalli](https://github.com/valentinogussalli) |
| **Camilo Tommasi** | [@CamiloTommasi](https://github.com/CamiloTommasi) |

El proyecto se diseñó, programó y probó entre los tres integrantes. El historial de commits y los pull requests muestran el trabajo de cada uno.

---

## 📁 Estructura del repositorio

```
.
├── PRINCIPAL/                 # Sistema de Gestión Educativa
│   ├── Principal.pas          # Programa principal (punto de entrada)
│   ├── Interfaz.pas           # Menús: principal, alumnos, seguimiento, listados, estadísticas
│   ├── Interfaz_aux.pas       # Marcos, textos centrados, encabezados y paginación
│   ├── Inicializacion.pas     # Carga de los índices (árboles) desde los archivos al iniciar
│   ├── Archivos.pas           # Tipos de registro y constantes (alumnos, evaluaciones, dificultades)
│   ├── Usa_archivo.pas        # Operaciones sobre archivos binarios
│   ├── Unit_arbol.pas         # Tipo nodo / puntero del árbol binario
│   ├── Usa_arbol.pas          # TDA Árbol Binario de Búsqueda (alta, búsqueda, recorridos, baja)
│   ├── Alumnos.pas            # ABM de alumnos
│   ├── Evaluaciones.pas       # Alta, modificación y consulta de evaluaciones
│   ├── Listados.pas           # Listados ordenados (recorridos inorden)
│   ├── Estadisticas.pas       # Estadísticas por período y por dificultad
│   └── Validaciones.pas       # Validación de legajos, nombres, fechas y valoraciones
│
└── CHATTERBOT/                # GeoBot – chatterbot de geografía
    ├── CHATTERBOT.pas         # Programa principal (punto de entrada)
    ├── Interfaz_paises.pas    # Pantalla de bienvenida y bucle de conversación
    ├── Declaracion_paises.pas # Tipos: registro país, vector, tipos de consulta
    ├── Datos_paises.pas       # Creación y carga de la base de datos de países (paises.dat)
    ├── Palabras_paises.pas    # Análisis de la entrada: detecta intención, país y región
    ├── Respuestas_paises.pas  # Generación de respuestas según el tipo de consulta
    ├── Busqueda_paises.pas    # Búsquedas por nombre, capital y región
    └── Utilidades_paises.pas  # Funciones auxiliares de texto y formato
```

---

## 🏫 1. Sistema de Gestión Educativa

Aplicación para registrar alumnos con **dificultades de aprendizaje** y hacer un seguimiento de su evolución mediante evaluaciones periódicas.

### Funcionalidades

**Gestión de alumnos**
- Alta, consulta, modificación y **baja lógica** de alumnos, identificados por un legajo de 8 dígitos.
- Cada alumno registra nombre y apellido, fecha de nacimiento, estado (activo/inactivo) y sus dificultades:
  1. Problemas del habla y lenguaje
  2. Dificultad para escribir
  3. Dificultades de aprendizaje visual
  4. Memoria y otras dificultades del pensamiento
  5. Destrezas sociales inadecuadas
- Reactivación de alumnos dados de baja.

**Seguimiento y evaluaciones**
- Alta de evaluaciones con la fecha del día, con una valoración de **0 a 4** para cada dificultad del alumno y una observación.
- Modificación y consulta de evaluaciones por fecha.

**Listados**
- Alumnos activos ordenados alfabéticamente.
- Evaluaciones de un alumno ordenadas por fecha.
- Alumnos que presentan una dificultad determinada.
- Paginación en pantalla.

**Estadísticas**
- Distribución de evaluaciones por dificultad dentro de un período de fechas.
- Dificultades con mayor grado acumulado de valoración en un período.
- Dificultades con mayor cantidad de alumnos activos, ordenadas con **ordenamiento por selección**.

### Diseño y estructuras de datos

- **Archivos binarios con tipo** (`file of record`): `alumnos.dat` y `evaluaciones.dat` guardan los datos en disco. Si no existen, se crean al iniciar.
- **Árboles Binarios de Búsqueda como índices en memoria**: al iniciar, el programa recorre los archivos y arma tres árboles, cada uno con la clave y la posición del registro en el archivo:

  | Árbol | Clave | Uso |
  |---|---|---|
  | `arb_leg` | Legajo | Búsqueda directa de alumnos |
  | `arb_ayn` | Apellido y nombre | Listados alfabéticos (recorrido inorden) |
  | `arb_ev` | Fecha + legajo | Evaluaciones ordenadas cronológicamente |

- **Acceso directo** al archivo (`seek`) a partir de la posición guardada en el árbol, sin recorrer el archivo de forma secuencial.
- **Baja lógica**: el registro no se borra, se marca como inactivo.
- **Modularización** en units con responsabilidades separadas (TDA árbol, archivos, validaciones, interfaz, lógica de negocio).

---

## 🌎 2. GeoBot: Chatterbot de geografía

Asistente conversacional en consola que responde preguntas sobre **25 países de América** (Norte, Central, Caribe y Sur). El usuario escribe en lenguaje natural y el bot identifica qué se le pregunta y sobre qué país.

### Qué se le puede preguntar

```
Cual es la capital de Argentina?
Dime informacion sobre Peru
Donde queda Honduras?
Cuantos habitantes tiene Brasil?
Que idioma se habla en Paraguay?
Que moneda usan en Ecuador?
Cual es la superficie de Chile?
Cual es la comida tipica de Mexico?
Cuando se independizo Uruguay?
Cual es el punto mas alto de Bolivia?
Con que paises limita Colombia?
Muestra los paises de America Central
Compara Argentina y Chile
Dame un dato curioso
ayuda
salir
```

### Cómo funciona

1. **Base de datos:** la primera vez que se ejecuta, crea `paises.dat` con los datos de cada país (capital, población, superficie, idioma, moneda, límites, independencia, comida típica, punto más alto). Después lo carga en un **vector de registros**.
2. **Análisis de la entrada** (`Palabras_paises`): busca palabras clave para clasificar la consulta en uno de los tipos del enumerado `TTipoConsulta` (capital, población, comparación, región, saludo, etc.) y extrae el o los países y la región mencionados.
3. **Respuesta** (`Respuestas_paises`): según el tipo de consulta, arma la respuesta con los datos encontrados.

---

## ▶️ Cómo compilar y ejecutar

### Requisitos
- [Free Pascal Compiler](https://www.freepascal.org/) 3.x, o el IDE [Lazarus](https://www.lazarus-ide.org/).

### Sistema de Gestión Educativa

```bash
cd PRINCIPAL
fpc -Mobjfpc Principal.pas
./Principal          # En Windows: Principal.exe
```

### GeoBot

```bash
cd CHATTERBOT
fpc CHATTERBOT.pas
./CHATTERBOT         # En Windows: CHATTERBOT.exe
```

> 💡 Conviene usar una terminal grande (por lo menos 110 × 30 caracteres), porque la interfaz posiciona el texto en coordenadas fijas.
> Los archivos `.dat` se crean en la carpeta desde donde se ejecuta el programa.

---

## 🧠 Conceptos aplicados

- Tipos de datos estructurados: registros, vectores y enumerados
- Archivos binarios con tipo y acceso directo
- Punteros y memoria dinámica
- Árboles binarios de búsqueda: inserción, búsqueda, recorridos preorden e inorden, eliminación
- Algoritmos de ordenamiento (selección) y de búsqueda
- Validación de datos de entrada
- Procesamiento de cadenas y reconocimiento de palabras clave
- Programación modular con units

---

<p align="center">
  Hecho por <b>Federico Haffner</b>, <b>Valentino Gussalli</b> y <b>Camilo Tommasi</b> · 2025
</p>
