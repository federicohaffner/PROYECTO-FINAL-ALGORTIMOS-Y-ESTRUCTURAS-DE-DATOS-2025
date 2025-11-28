unit listados;
    
interface
    
uses
    crt, SysUtils, Classes, unit_arbol, archivos, validaciones;

procedure listado_alumnos(arb_ayn:t_punt);
procedure listado_ev (arb_ev:t_punt; legajo:string);
procedure listado_discapacidad (arb_ayn:t_punt);
    
implementation
    
procedure listado_alumnos(arb_ayn:t_punt);
begin
    if arb_ayn<>nil then
    begin
        writeln('-----LISTADO DE ALUMNOS-----');
        inorden(arb_ayn);
    end
    else
    begin
        writeln('No hay alumnos cargados en el sistema.');      
        writeln('Presione una tecla para continuar...');  
        readkey;
    end;
end;

procedure listado_ev (arb_ev:t_punt; legajo:string);
begin
    if arb_ev<>nil then
    begin
        writeln('-----LISTADO DE EVALUACIONES-----');
        INORDEN_leg(arb_ev, legajo);  
    end
    else
    begin
        writeln('No hay evaluaciones cargadas en el sistema.');
        writeln('Presione una tecla para continuar...');  
        readkey;
    end;
end;

procedure listado_discapacidad (arb_ayn:t_punt, disc:byte; var arch:t_archivo_alumnos  );
begin
    if arb_ayn<>nil then
    begin
        writeln('-----LISTADO DE ALUMNOS CON DISCAPACIDAD-----');
        inorden_disc(arb_ayn, disc, arch);
    end
    else
    begin
        writeln('No hay evaluaciones cargadas en el sistema.');
        writeln('Presione una tecla para continuar...');  
        readkey;
    end;
end;

end.