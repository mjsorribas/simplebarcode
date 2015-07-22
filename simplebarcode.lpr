program simplebarcode;
uses crt;
var
  ndec: integer;
  wh: Char;
  nbin: String;
  codigo: String;

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
begin
  clrscr;
  nbin:='';
  codigo:='';
  writeln('Generador de Codigo de Barras para legajos de 4 Digitos');
  writeln('Ingrese el N. de Legajo');
  readln(ndec);
  // Bucle principal
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
  //muestro el codigo de barras
  writeln('Codigo de Barras:  ', codigo);


end.

