unit Archivos;
{$mode ObjFPC}{$H+}
interface
const
     ruta_1= 'alumnos.dat';
     ruta_2= 'evaluaciones.dat';
     DIFICULTADES: ARRAY[1..5] OF STRING= ('PROBLEMAS DEL HABLA Y LENGUAJE',
                                             'DIFICULTAD PARA ESCRIBIR',
                                             'DIFICULTADES DE APRENDIZAJE VISUAL',
                                             'MEMORIA Y OTRAS DIFICULTADES DEL PENSAMIENTO',
                                             'DESTREZAS SOCIALES INADECUADAS');
type
  t_dato_alumnos= record
    legajo: string[10];
    ayn: string[100];
    fecha_nac: string[10];
    estado: boolean;
    dificultades: array [1..5] of boolean;
  end;
  t_archivo_alumnos= file of t_dato_alumnos;
  t_dato_evaluaciones= record
    legajo: string[10];
    fecha_ev: string[10];
    valoracion: array [1..5] of 0..4;
    observacion: string[100];
  end;
  t_archivo_evaluaciones= file of t_dato_evaluaciones;
  t_vec_enteros = array[1..5] of integer;
  t_vec_cadenas = array[1..5] of string;
implementation
end.   