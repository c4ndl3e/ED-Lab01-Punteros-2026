program punterosej5_RESUELTO;

uses
    SysUtils;

{ Declaración de constantes }
const
    MAX = 4; { 2. Declaración de constantes }

{ Declaración de tipos }
type
    coordenada_3D = record { 1. Declara un tipo coordenada_3D para puntos con coordenadas x,y,z }
      x: integer;
      y: integer;
      z: integer;
    end;

    TPtCoord = ^coordenada_3D;

    TArray= array [1..MAX] of TPtCoord;

{ Declaración de variables }
var
    lista: TArray;{ 2. Declara un array de MAX punteros a coordenadas_3D }
    i: integer;



{ Procedimiento para imprimir una coordenada_3D }
procedure printCord (pos: integer; l: TArray);
begin
  writeln('Coordenada de la posicion ', pos, ': (',l[pos]^.x,', ',l[pos]^.y,', ',l[pos]^.z,')');
  writeln;
end;


{ * Implementa un procedimiento que muestre por pantalla el contenido de cada posición }
procedure printAll (l: TArray);
var
    i: integer;
begin
  for i:= 1 to MAX do
    printCord(i,l);
  writeln;
end;


{ 4. Implementa un procedimiento que libere la memoria asignada a una posición }
procedure disposeCord (pos: integer; l: TArray);
begin
  dispose(l[pos]);
end;


{ 4.' Implementa un procedimiento que libere la memoria asignada a todas las posiciones }
procedure disposeAll (l:TArray);
var
    i: integer;
begin
  for i:= 1 to MAX do
    dispose(l[i]);
end;


{ 5. Implementa una función que sume todas las x de las coordenadas }
function sumXCords (l: TArray): integer;
var
    i: integer;
begin
  sumXCords:= 0;
  for i:= 1 to MAX do begin
    sumXCords:= sumXCords + l[i]^.x;
  end;
end;


{ 5.' Implementa una función que sume las coordenadas de todas las posiciones }
function sumAllCords (l: TArray): integer;
var
    i: integer;
begin
  sumAllCords:= 0;
  for i:= 1 to MAX do begin
    sumAllCords:= sumAllCords + l[i]^.x + l[i]^.y + l[i]^.z;
  end;
end;


{ 6. (Opcional) Implementa un procedimiento que permita añadir una coordenada en la primera
    posición libre del array
procedure addCord (var l: TArray);
var
    i,contador: integer;
    c: coordenada_3D;
begin
  writeln('Escriba la coordenada a anadir');
  write('x: ');
  readln(c.x);
  write('y: ');
  readln(c.y);
  write('z: ');
  readln(c.z);

  contador:= 0;
  for i:= 1 to MAX do begin
    if l[i] = NIL then begin
      new(l[i]);
      l[i]^:= c;
    end
    else
      contador:= succ(contador);
  end;
  if contador = MAX then
    writeln('No hay espacios libres para añadir la coordenada :(')
  else
    writeln('Coordenada añadida correctamente! :)');
  writeln;
end; }


{ 7. Implementa una función que calcule la máxima coordenada y (debes comprobar  antes,
     pues puede que alguna posición no tenga coordenada y esté a NIL)}
function maxCord (l: TArray): integer;
var
    i,suma,sumaAnt: integer;
begin
  maxCord:= 0;
  sumaAnt:= 0;
  for i:= 1 to MAX do begin
    if not(l[i] = NIL) then begin

      suma:= l[i]^.x + l[i]^.y + l[i]^.z;
      if suma > sumaAnt then begin
        sumaAnt:= suma;
        maxCord:= i;
      end;

    end;
  end;
end;


begin
  for i:=1 to MAX do begin{ 3. Crea una coordenada_3D en cada una de las posiciones inicializado todas las coordenadas con números aleatorios }
    new(lista[i]);
    lista[i]^.x:= random(100)+1;
    lista[i]^.y:= random(100)+1;
    lista[i]^.z:= random(100)+1;
  end;

  printAll(lista);
  writeln('La suma de las coordenadas X es: ', sumXCords(lista));
  writeln('La suma de todas las coordenadas es: ', sumAllCords(lista));
  writeln('La maxima coordenada es la coordenada ',maxCord(lista),' con');
  writeln('x: ',lista[maxCord(lista)]^.x,'  y: ',lista[maxCord(lista)]^.y,'  z: ',lista[maxCord(lista)]^.z);
  disposeAll(lista);
  printAll(lista);


readln;
end.

