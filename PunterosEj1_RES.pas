{ 
    Programa que demuestra el uso de punteros en Pascal 
}
program PunterosEj1_RES;

var
    x: Integer;          { Declara variable entera (x) }
    p_ent: ^Integer;     { Declara una variable de tipo puntero a entero (p_ent) }

begin
    x := 100;            { Da el valor 100 a x }

    { Crea un entero dinámicamente con p_ent y dale el valor que tiene actualmente x }
    New(p_ent);
    p_ent^ := x;

    { Imprime por pantalla el valor contenido en el entero al que apunta p_ent }
    WriteLn('Valor de p_ent^: ', p_ent^);

    { Crea con new un nuevo entero dinámicamente }
    New(p_ent);

    { Imprime por pantalla el valor contenido en el entero al que apunta p_ent }
    WriteLn('Valor de p_ent^ después de New: ', p_ent^);

    { Pon el puntero p_ent a apuntar a x }
    p_ent := @x;

    { Súmale 100 al entero apuntado por el puntero p_ent }
    p_ent^ := p_ent^ + 100;

    { Imprime por pantalla el valor de x y también del entero al que apunta p_ent }
    WriteLn('Valor de x: ', x);
    WriteLn('Valor de p_ent^: ', p_ent^);

    { Pon el puntero p_ent a NIL }
    p_ent := nil;

    { Libera la memoria asociada al nuevo entero }
    Dispose(p_ent);

    { Suma 100 a x pero sin usar x en la operación de suma (solo usando p_ent) }
    p_ent := @x;
    p_ent^ := p_ent^ + 100;

    { Muestra por pantalla que son iguales }
    WriteLn('Valor de x después de sumar 100 usando p_ent: ', x);

    { Libera toda la memoria asociada a p_ent y termina }
    Dispose(p_ent); { Esto da un error, ya que p_ent ya no apunta a memoria dinámica. Apuntar a memoria estática no permite liberar memoria. }
end.