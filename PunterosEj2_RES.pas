program PunterosEj2_RES;

uses
    SysUtils;

var
    V: array[0..2] of Integer;
    p: ^Integer;
    i: Integer;

begin
    { Crea un array de 3 enteros V e inicialízalo con números aleatorios. }
    Randomize;
    for i := 0 to 2 do
        V[i] := Random(100);

    { Muestra sus valores por pantalla }
    WriteLn('Valores iniciales del array:');
    for i := 0 to 2 do
        WriteLn('V[', i, '] = ', V[i]);

    { Declara un puntero a entero p y ponlo a apuntar a la primera posición del array }
    p := @V[0];

    { Pon el valor 100 en el entero apuntado por p }
    p^ := 100;

    { Muestra los valores del array “V” por pantalla }
    WriteLn('Valores del array después de asignar 100 a la primera posición:');
    for i := 0 to 2 do
        WriteLn('V[', i, '] = ', V[i]);

    { Recorre con p todas las posiciones del array para ponerlas todas a cero }
    for i := 0 to 2 do
    begin
        p^ := 0;
        p := p + 1;         //Inc(p); // Incrementa el puntero
    end;

    { Muestra los valores del array “V” por pantalla }
    WriteLn('Valores del array después de poner todas las posiciones a cero:');
    for i := 0 to 2 do
        WriteLn('V[', i, '] = ', V[i]);
end.