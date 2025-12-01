unit unit_arbol;
{$mode ObjFPC}{$H+}
interface
type
   t_dato_arbol = record
      clave: string[100];
      pos_arch: integer;
   end;

   t_punt = ^t_nodo;

   t_nodo = record
      info: t_dato_arbol;
      sai, sad: t_punt;
   end;
implementation
end.            