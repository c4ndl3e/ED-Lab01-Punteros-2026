program PunterosEj6;

uses SysUtils, crt;



{
    Vamos a hacer un simulador de "Isla de la Tentación" en Pascal. Para ello, sigue los siguientes pasos:
}

const
  NUM_PAREJAS= 1;
  NUM_PARTICIPANTES= 2 * (NUM_PAREJAS + (NUM_PAREJAS div 2));


type

  TRol= (pareja, tentador);

  TParticipante = record
    nombre: string;
    edad: integer;
    rol: TRol;
    otroParticipante: ^TParticipante;
  end;

  TPtParticipante = ^TParticipante;

  TArray = array [1..NUM_PARTICIPANTES] of TPtParticipante;


var
  lista: TArray;{ 2. Crea un array de MAX punteros a Participante }
  posicion,i: integer;
  seguir: char;


procedure crearPte (var p: TParticipante; nombre: string; edad: integer; rol: TRol); {3. Crea un procedimiento que cree un participante con nombre, edad y rol. Otro participante será nil.}
begin
  p.Nombre:= nombre;
  p.Edad:= edad;
  p.Rol:= rol;
  p.otroParticipante:= NIL;
end;


procedure crearPareja (p1,p2: TPtParticipante);  {4. Crea un procedimiento que asigne una pareja a un participante, recibirá dos parámetros, los dos participantes}
begin
  p1^.otroParticipante:= p2;
  p2^.otroParticipante:= p1;
end;


procedure inicializarIsla (var l: TArray); {5. Crea un procedimiento aud inicialice la isla de las tentaciones. Por cada 2 parejas, habrá un tentador.}
var
  i,edad,parejas,participantes: integer;
  pte: TParticipante;
  nombre: string;
  rol: TRol;
begin
  participantes:= 1;
  parejas:= 1;

  while participantes <= NUM_PARTICIPANTES do begin
    new(l[participantes]);
    writeln('Participante ',participantes);
    write('Nombre: ');
    readln(nombre);
    write('Edad: ');
    readln(edad);
    if parejas <= NUM_PAREJAS then
      rol:= pareja
    else
      rol:= tentador;
    crearPte(pte,nombre,edad,rol);
    l[participantes]^:= pte;
    if ( parejas <= NUM_PAREJAS ) and not(odd(participantes)) then begin
      crearPareja(l[participantes-1],l[participantes]);
      parejas:= succ(parejas);
    end;

    participantes:= succ(participantes);
  end;

end;

{6. Crea un procedimiento que muestre por pantalla la isla de las tentaciones de la siguiente manera:
            - Nombre: XXXX
            - Edad: XX
            - Rol: Pareja/Tentador
            - Pareja: XXXX --> si tuviera pareja
            - Infiel --> si su rol fuese pareja, pero no la tiene
            - Tentó a: XXXX --> si fuese tentador y ahora tiene pareja}
procedure estadoIsla(var l: TArray);
var
  i: integer;
begin
  clrscr;
  for i:= 1 to NUM_PARTICIPANTES do begin
    writeln('Participante ',i);
    writeln('  Nombre: ',l[i]^.nombre,'  Edad: ',l[i]^.edad, '  Rol: ',l[i]^.rol);
    if l[i]^.rol = pareja then begin
      if not( l[i]^.otroParticipante = NIL ) then
        writeln('  Pareja: ',l[i]^.otroParticipante^.nombre)
      else
        writeln('  Infiel');
    end
    else if not( l[i]^.otroParticipante = NIL ) then
      writeln('  Tento a: ',l[i]^.otroParticipante^.nombre);
    writeln;
  end;
end;


{7. Crea un procedimiento que simule una ronda de tentación. En cada ronda, se seleccionará una pareja y un tentador:
    - Se seleccionará al azar (50/50) quién de los dos será tentado. 
    - Se determinará si la pareja es infiel o no (25/75). 
    - Se actualizarán los datos. Si ha sido infiel, perderán su pareja. El tentador, tendrá una nueva pareja.}
procedure rondaTentacion(var l: TArray);
var
  parTentada,pTentador,prob: integer;
  pTentado: ^TParticipante;
begin
  parTentada:= random(NUM_PAREJAS * 2) + 1;
  pTentador:= (NUM_PAREJAS*2) + ( random(NUM_PARTICIPANTES-(NUM_PAREJAS*2)) +1 );

  prob:= random(2)+ 1;
  if prob = 1 then
    pTentado:= l[parTentada]
  else
    pTentado:= l[parTentada]^.otroParticipante;

  prob:= 1{random(4)+1};
  if prob = 1 then begin
    pTentado^.otroParticipante^.otroParticipante:= NIL;
    crearPareja(pTentado,l[pTentador]);
  end;
end;


{
    8. Genera un programa que le pregunte al usuario si quiere jugar una ronda más o no. 
    Si el usuario decide que sí, se realizará una ronda más. Si decide que no, se mostrará el estado final de la isla de las tentaciones.
}
begin

inicializarIsla(lista);
estadoIsla(lista);

repeat
  write('Quieres hacer otra ronda? (S/N): ');
  readln(seguir);
  seguir:= upcase(seguir);
  if seguir = 'S' then begin
    rondaTentacion(lista);
    estadoIsla(lista);
  end;
until(seguir <> 'S') ;

readln;
end.
