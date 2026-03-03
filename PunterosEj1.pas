{ 
    Programa que demuestra el uso de punteros en Pascal 
}

program PunterosEj1;

uses
    crt;

var
  x: integer; { Declara variable entera (x) }
  p_ent: ^integer; { Declara una variable de tipo puntero a entero (p_ent) }

begin
  x := 100;  { Da el valor 100 a x }
  new(p_ent); { Crea un entero dinámicamente con p_ent y dale el valor que tiene actualmente x }
  p_ent^ := x; { Imprime por pantalla el valor contenido en el entero al que apunta p_ent }
  writeln(p_ent^);

  new(p_ent); { Crea con new un nuevo entero dinámicamente }
  writeln(p_ent^); { Imprime por pantalla el valor contenido en el entero al que apunta p_ent }
  p_ent:= @x; { Pon el puntero p_ent a apuntar a x }
  p_ent^:= p_ent^ + 100; { Súmale 100 al entero apuntado por el puntero p_ent }
  writeln('x: ',x,'  p_ent: ',p_ent^); { Imprime por pantalla el valor de x y también del entero al que apunta p_ent }
  p_ent:= NIL; { Pon el puntero p_ent a NIL }
  dispose(p_ent); { Libera la memoria asociada al nuevo entero }
  p_ent:= @x; { Suma 100 a x pero sin usar x en la operación de suma (solo usando p_ent) }
  p_ent^:= p_ent^ + 100;
  writeln('x: ',x,'  p_ent: ',p_ent^); { Muestra por pantalla que son iguales }
  dispose(p_ent); { Libera toda la memoria asociada a p_ent y termina }

  readln;
end.
