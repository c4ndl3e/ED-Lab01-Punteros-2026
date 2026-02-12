program PunterosEj3_RES;
type
    { Declara un tipo de registro llamado “nodo” con dos campos: un entero y un puntero a “nodo” }
    nodo = record
        valor: Integer;
        otro_nodo: ^nodo;
    end;

var
    { Declara una variable de tipo puntero a nodo }
    punteroNodo: ^nodo;

begin
    { Crea un nodo en memoria dinámica (heap) }
    New(punteroNodo);

    { Dale valor 100 al campo entero de este nodo }
    punteroNodo^.valor := 100;

    { Pon a nil el campo puntero del nodo }
    punteroNodo^.otro_nodo := nil;

    { Pon ahora el puntero del nodo a apuntar al propio nodo }
    punteroNodo^.otro_nodo := punteroNodo;

    { En este punto hay dos instrucciones alternativas para liberar la memoria dinámica creada: }
    { Alternativa 1: Liberar el nodo directamente }
    Dispose(punteroNodo);

    { Alternativa 2: Liberar el nodo a través del campo puntero }
    { Dispose(punteroNodo^.otro_nodo); }

    { Termina }
end.