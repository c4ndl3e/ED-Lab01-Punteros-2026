program PunterosEj2;

uses
    SysUtils;

const
  ini= 1;
  fin= 3;

type
  TArray= Array [ini..fin] of integer;

var
  V: TArray;
  i: integer;
  p: ^integer;

procedure mostrarArray (miArray: TArray);
var
  i: integer;
begin
  for i:= ini to fin do  begin
    writeln(miArray[i]);
  end;
end;

begin
  randomize;

  for i:= ini to fin do { Crea un array de 3 enteros V e inicialízalo con números aleatorios. }
    v[i]:= random(100)+1;

  mostrarArray(V); { Muestra sus valores por pantalla }

  p:= @v[ini]; { Declara un puntero a entero p y ponlo a apuntar a la primera posición del array }
  v[ini]:= 100; { Pon el valor 100 en el entero apuntado por p }
  mostrarArray(V); { Muestra los valores del array “V” por pantalla }
  for i:= ini to fin do begin { Recorre con p todas las posiciones del array para ponerlas todas a cero }
    p:= @v[i];
    p^:= 0;
  end;

  mostrarArray(V); { Muestra los valores del array “V” por pantalla }


  readln(i);
end.

