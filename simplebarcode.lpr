program simplebarcode;
uses crt, sysutils;

//Funcion que genera el Codigo de Barras
function generarCodigo(nbin:String):String;
var   x: integer;
      aux: String;
begin
  aux:='';
  for x:= length(nbin) downto 1 do
         begin

              if nbin[x]='0' then
                  begin
                       aux:=aux+ ' ';
                  end
              else
                  begin
                       aux:=aux+ chr(124);
                  end;
         end;
  generarCodigo:=aux;
end;

//function obtenerDigitoVerificador(numero):integer;
//begin

//end;
//Procedimiento para Obtener el Codigo de Barras
procedure obtenerCodigo();
var
   ndec: integer;
   wh: Char;
   nbin: String;
   codigo: String;
   fecha:string;
   aux:string;

          begin
               nbin:='';
               codigo:='';
               writeln('Ingrese el N. de Legajo');
               readln(ndec);
               // Bucle principal
               //fecha:= DateToStr(Date);
               //aux:=Concat(IntToStr(ndec), fecha , '0');
               //writeln(aux);
               //ndec:=StrToInt(aux);
               repeat
                     begin
                          if ndec mod 2 = 0 then
                             begin
                                  wh:='0';
                             end
                          else
                              begin
                                   wh:='1';
                              end;
                          nbin:= nbin + wh ;
                          ndec:= ndec div 2 ;
                     end;
               until ndec = 0;
               // genero el codigo de barras
               codigo:= generarCodigo(nbin);
               writeln('Codigo de Barras:  ');
               writeln(codigo);
               writeln(codigo);
end;
procedure bienvenida();
var opcion: integer;
         begin
           repeat
                 opcion:=0;
                 clrscr;
                 writeln('Generador de Codigo de Barras para legajos de 4 Digitos');
                 writeln('Opciones:');
                 writeln('1 - Generar Nuevo Codigo');
                 writeln('2 - Para SALIR presione S');
                 readln(opcion);
                 if opcion=1 then
                    begin
                         obtenerCodigo();
                         readln(opcion);
                    end;
           until opcion=2;
         end;
begin
    bienvenida();
end.

