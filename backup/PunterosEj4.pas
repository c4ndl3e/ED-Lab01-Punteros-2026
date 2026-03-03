program PunterosEj4;

uses
    crt;

const
    MAX = 5;  { 1.a Declarar un array de MAX punteros a enteros }

type
   { 1.b Declarar un array de MAX punteros a enteros }
   tparray = array[0..MAX] of ^integer;

var
    { 1.c Declarar un array de MAX punteros a enteros }
    ptrArray: tparray;
    option: Char; // Variable para la opción del menú
    i,num: integer;

{ 6.a Implementa una función que calcule el máximo número del array (debes comprobar 
antes, pues puede que alguna posición no tenga un número y esté a NIL)}
function MaxArray(ptrArray: tparray): Integer;
var
    i: integer;
begin
    MaxArray:= -1;
    for i:= 1 to MAX do begin
      if not(ptrArray[i] = NIL) then begin
        if ptrArray[i]^ > MaxArray then
        MaxArray:= ptrArray[i]^;
      end;
    end;
end;

{ 7.a Implementa una función que compute la suma de todos los enteros (de nuevo 
asegúrate de no intentar sumar los que estén a NIL) }
function SumArray(ptrArray: tparray): Integer;
var
    i: integer;
begin
    sumArray:= 0;
    for i:= 1 to MAX do begin
      if not(ptrArray[i] = NIL) then
      sumArray:= sumArray + ptrArray[i]^;
    end;
end;

{ 3.a Implementa un procedimiento que muestre por pantalla el contenido de cada posición }
procedure PrintArray(ptrArray: tparray);
var
    i: integer;
begin
    writeln;
    for i:= 1 to MAX do begin
      if ptrArray[i] = NIL then
        write('[NIL]')
      else
        write('[',ptrArray[i]^,']');
    end;
    writeln;
end;

{ 4.a Implementa un procedimiento que ponga a cero todos los números }
procedure ZeroArray(var ptrArray: tparray);
begin
    for i:= 1 to MAX do begin
      ptrArray[i]^ := 0;
    end;
end;

{ 5. Implementa un subprograma que ponga todos los punteros que no lo estén, a NIL }
procedure NilArray(var ptrArray: tparray);
begin
    for i:= 1 to MAX do begin
      if not( ptrArray[i] = NIL) then
      ptrArray[i] := NIL;
    end;
end;

begin
    for i:= 1 to MAX do begin { 2. Crea un entero en cada una de las posiciones inicializado a un número aleatorio }
      num:= random(100)+1;
      new(ptrArray[i]);
      ptrArray[i]^ := num;
    end;

    repeat
        ClrScr;
        WriteLn('1. Mostrar array'); { 3.b }
        WriteLn('2. Poner a cero array'); { 4.b }
        WriteLn('3. Poner a NIL los punteros'); { 5.b }
        WriteLn('4. Máximo array'); { 6.b }
        WriteLn('5. Suma array'); { 7.b }
        WriteLn('0. Salir');
        Write('Opción: ');
        ReadLn(option);

        case option of
            '1': PrintArray(ptrArray);
            '2': ZeroArray(ptrArray);
            '3': NilArray(ptrArray);
            '4': WriteLn('Máximo: ', MaxArray(ptrArray));
            '5': WriteLn('Suma: ', SumArray(ptrArray));
        end;
        WriteLn('Pulsa una tecla para continuar...');
        ReadKey;
    until option = '0';

    NilArray(ptrArray);

    readln;
end.
