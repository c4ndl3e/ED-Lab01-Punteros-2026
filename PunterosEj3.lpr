program PunterosEj3;
type
  nodo = record  { Declara un tipo de registro llamado “nodo” con dos campos: un entero y un puntero a “nodo” }
    entero: integer;
    puntero: ^nodo;
  end;


var
  p_nodo: ^nodo; { Declara una variable tipo puntero a nodo }

begin
  new(p_nodo);  { Crea un nodo en memoria dinámica (heap) }
  p_nodo^.entero:= 100;  { Dale valor 100 al campo entero de este nodo }
  p_nodo^.puntero:= NIL; { Pon a nil el campo puntero del nodo }

{ En este punto hay dos instrucciones alternativas para liberar la memoria dinámica creada: }
  dispose(p_nodo);  { Alternativa 1: Liberar el nodo directamente }


  dispose(p_nodo^.puntero);   { Alternativa 2: Liberar el nodo a través del campo puntero }

{ Termina }
end.

