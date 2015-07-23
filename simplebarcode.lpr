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

//funcion para calculoDigitoControlEAN (numero):integer;
function obtenerDigitoVerificador (Ean: String): Integer; overload;
//Calcula y devuelve el dígito verificador de una cadena de código de barras EAN13
//o EAN8 .Devcuelve -1 en caso de ser incorrecto.
var
  SP, SI, I, L:Integer;
  Impar: Boolean;
begin
  L := Length(Ean);
  if (L = 8) or (L = 13) then
  begin
    SI := 0;
    SP := 0;
    I := L - 1;
    Impar := True;
    repeat
      if Impar then
        SI := SI + StrToInt(Ean[I])
      else
        SP := SP + StrToInt(Ean[I]);
      Impar := not Impar;
      I := I - 1;
    until I =0;
    if Impar then
      SI := SI*3
    else
     SP := SP*3;
    Result := 10-(SI+SP) mod 10;
  end
  else
    Result:= -1;
end;

function obtenerFecha():String;
var YY,MM,DD : Word;
     formateado : string;
begin
   DeCodeDate (Date,YY,MM,DD);
   formateado := (format('%d%d%d',[dd,mm,yy]));
   //agrego las condiciones para evitar que la fecha tenga menos digitos y le
   //agrego un 0 extra para validar los 13 de ean 13
   if (length(formateado)= 8) then
             formateado:= Concat(formateado,'0');
   if (length(formateado)= 7) then
             formateado:= Concat(formateado,'00');
   if (length(formateado)= 6) then
             formateado:= Concat(formateado,'000');

   obtenerFecha:=  formateado;
end;
//Procedimiento para Obtener el Codigo de Barras
procedure obtenerCodigo();
var
   ndec: integer;
   wh: Char;
   nbin: String;
   codigo: String;
   fecha:string;
   aux:string;
   dverif: integer;

          begin
               nbin:='';
               codigo:='';
               writeln('Ingrese el N. de Legajo');
               readln(ndec);
               // Bucle principal
               fecha:=obtenerFecha();
               writeln('Fecha:',fecha);
               aux:=Concat(IntToStr(ndec), fecha );
               writeln(aux);
               dverif:= obtenerDigitoVerificador(aux);
               aux:=Concat(aux, IntToStr(dverif));
               ndec:=StrToInt(aux);
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

