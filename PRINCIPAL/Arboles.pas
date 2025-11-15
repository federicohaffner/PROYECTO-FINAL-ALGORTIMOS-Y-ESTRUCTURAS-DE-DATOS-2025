unit UNIT_ARBOL;
Interface
uses
    crt, sysutils;

TYPE
  T_DATO_ARBOL=RECORD
    clave:string[100];
    pos_arch:word;
  end;

  T_PUNT = ^T_NODO;

  T_NODO = RECORD
    INFO:T_DATO_ARBOL;
    SAI,SAD: T_PUNT;
  END;

PROCEDURE CREAR_ARBOL (VAR RAIZ:T_PUNT);
PROCEDURE AGREGAR (VAR RAIZ:T_PUNT; X:T_DATO_ARBOL);
FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
FUNCTION ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;
PROCEDURE AGREGAR_ARBOL_EVAL(VAR RAIZ:T_PUNT; X:T_DATO_ARBOL);
PROCEDURE INORDEN(VAR RAIZ:T_PUNT);
PROCEDURE PREORDEN(RAIZ:T_PUNT; BUSCADO:String; VAR ENC:BOOLEAN; VAR X:T_DATO_ARBOL);
procedure suprime(var raiz:t_punt; x:t_dato_arbol);
function suprime_min(var raiz:t_punt):t_dato_arbol;

implementation

PROCEDURE CREAR_ARBOL (VAR RAIZ:T_PUNT);
BEGIN
  RAIZ:= NIL;
END;

PROCEDURE AGREGAR (VAR RAIZ:T_PUNT; X:T_DATO_ARBOL);
BEGIN
 IF RAIZ = NIL THEN
 BEGIN
  NEW(RAIZ);
  RAIZ^.INFO:=X;
  RAIZ^.SAI:= NIL;
  RAIZ^.SAD:= NIL;
 END
 ELSE
 IF (RAIZ^.INFO.clave > X.clave) THEN
  AGREGAR (RAIZ^.SAI,X)
 ELSE
  AGREGAR (RAIZ^.SAD,X)
END;

PROCEDURE AGREGAR_ARBOL_EVAL(VAR RAIZ:T_PUNT; X:T_DATO_ARBOL);
var
   menor:boolean;
BEGIN
 IF RAIZ = NIL THEN
 BEGIN
  NEW(RAIZ);
  RAIZ^.INFO:=X;
  RAIZ^.SAI:= NIL;
  RAIZ^.SAD:= NIL;
 END
 ELSE
 BEGIN
   menor:=evalua_fecha_leg_mayor(RAIZ^.INFO.clave,X.clave);
   IF menor THEN
    AGREGAR_ARBOL_EVAL(RAIZ^.SAI,X)
   ELSE
    AGREGAR_ARBOL_EVAL(RAIZ^.SAD,X)
 END;
END;

FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
BEGIN
 ARBOL_VACIO:= RAIZ = NIL;
END;

FUNCTION ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;
BEGIN
 ARBOL_LLENO:= GETHEAPSTATUS.TOTALFREE < SIZEOF (T_NODO);
END;

procedure suprime(var raiz:t_punt; x:t_dato_arbol);
begin
 if raiz <> nil then
    if upcase(x.clave) < upcase(raiz^.info.clave) then
       suprime(raiz^.sai,x)
    else
        if upcase(x.clave) > upcase(raiz^.info.clave) then
           suprime (raiz^.sad,x)
        else
            if (raiz^.sai = nil) and (raiz^.sad = nil) then
               raiz:= nil
            else
                if (raiz^.sai = nil) then
                   raiz:= raiz^.sad
                else
                    if (raiz^.sad = nil) then
                       raiz:= raiz^.sai
 else
   raiz^.info:= suprime_min (raiz^.sad)
end;

function suprime_min(var raiz:t_punt):t_dato_arbol;
var
   dir:T_PUNT;
begin
 if RAIZ^.SAI = nil then
  begin
   suprime_min:= raiz^.info;
   DIR:=RAIZ;
   raiz:=raiz^.sad;
   DISPOSE (DIR);
  end
  else
   suprime_min:= suprime_min (raiz^.sai)
end;            

PROCEDURE PREORDEN(RAIZ:T_PUNT; BUSCADO:String; VAR ENC:BOOLEAN; VAR X:T_DATO_ARBOL);
BEGIN
  IF (RAIZ = NIL) THEN
  ENC:= FALSE
 ELSE
  IF (upcase(RAIZ^.INFO.clave) = upcase(BUSCADO)) THEN
  BEGIN
   ENC:= TRUE;
   X:=RAIZ^.INFO;
  END
  ELSE IF upcase(RAIZ^.INFO.clave) > upcase(BUSCADO) THEN
   PREORDEN(RAIZ^.SAI,BUSCADO,ENC,X)
   ELSE
   PREORDEN(RAIZ^.SAD,BUSCADO,ENC,X)
END;

PROCEDURE INORDEN(VAR RAIZ:T_PUNT);
BEGIN
  IF RAIZ <> NIL THEN
  BEGIN
    INORDEN (RAIZ^.SAI);
    WRITELN (RAIZ^.INFO.clave);
    WRITELN (RAIZ^.INFO.pos_arch);
    INORDEN (RAIZ^.SAD);
 end;
END;

Procedure arbol_en_memoria(var archivo_1:t_archivo_alumnos; var archivo_2:t_archivo_evaluaciones; var raiz, raiz_2, raiz_3:t_punt);
begin
   crear_abrir(archivo_1);
   crear_abrir_2(archivo_2);
   if not (archivo_vacio(archivo_1)) then
   genera_arboles_alum(archivo_1,raiz,raiz_2)
   else
   begin
     crear_arbol(raiz);
     crear_arbol(raiz_2);
   end;
   if not (archivo_vacio(archivo_2)) then
    genera_arbol_eval(archivo_2,raiz_3)
   else
    crear_arbol(raiz_3);
end;


END.
