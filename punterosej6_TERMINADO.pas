program punterosej6_CASI_TERMINADO;

uses SysUtils, crt;



{
    Vamos a hacer un simulador de "Isla de la Tentación" en Pascal. Para ello, sigue los siguientes pasos:
}

const
  NUM_PAREJAS= 2;
  NUM_PARTICIPANTES= NUM_PAREJAS*2 + NUM_PAREJAS;


type

  TRol= (pareja, tentador);

  PtPte= ^TParticipante;

  TParticipante = record
    nombre: string;
    edad: integer;
    rol: TRol;
    otroParticipante: ^TParticipante;
  end;

  TArray = array [1..NUM_PARTICIPANTES] of ^TParticipante;


var
  lista: TArray;{ 2. Crea un array de MAX punteros a Participante }
  seguir: char;


procedure crearPte (var p: ptPte; nombre: string; edad: integer; rol: TRol); {3. Crea un procedimiento que cree un participante con nombre, edad y rol. Otro participante será nil.}
begin
  new(p);
  p^.Nombre:= nombre;
  p^.Edad:= edad;
  p^.Rol:= rol;
  p^.otroParticipante:= NIL;
end;


procedure crearPareja (var p1,p2: ptPte);  {4. Crea un procedimiento que asigne una pareja a un participante, recibirá dos parámetros, los dos participantes}
begin
  p1^.otroParticipante:= p2;
  p2^.otroParticipante:= p1;
end;


procedure inicializarIsla (var l: TArray); {5. Crea un procedimiento aud inicialice la isla de las tentaciones. Por cada 2 parejas, habrá un tentador.}
var
  i,edad: integer;
  antPte: ^TParticipante;
  nombre: string;
  rol: TRol;

begin
  antPte:= NIL;
  i:= 0;

  repeat

      i:= succ(i);
      writeln('Participante ',i); {--> Pido nombre y edad}
      write('Nombre: ');
      readln(nombre);
      write('Edad: ');
      readln(edad);

      if i <= (NUM_PAREJAS*2) then
        rol:= pareja
      else
        rol:= tentador;

      crearPte(l[i],nombre,edad,rol);
      if (not odd(i)) and (l[i]^.rol = pareja) and (antPte^.Rol = pareja) and (antPte <> NIL) then
        crearPareja(l[i],l[i-1]);
      antPte:= l[i];
      {writeln('Rol: ',l[i]^.rol);
      if not(l[i]^.otroParticipante = NIL) then
        writeln('Pareja: ',l[i]^.otroParticipante^.nombre);}

  until (i = NUM_PARTICIPANTES);


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

    if (l[i]^.rol = pareja) and (l[i]^.otroParticipante = NIL)  then
      writeln('  Pareja: Infiel')
    else if l[i]^.rol = pareja then
      writeln('  Pareja: ',l[i]^.otroParticipante^.nombre)
    else if not (l[i]^.otroParticipante = NIL) then
      writeln('Tento a ', l[i]^.otroParticipante^.nombre);
    end

end;


{7. Crea un procedimiento que simule una ronda de tentación. En cada ronda, se seleccionará una pareja y un tentador:
    - Se seleccionará al azar (50/50) quién de los dos será tentado. 
    - Se determinará si la pareja es infiel o no (25/75). 
    - Se actualizarán los datos. Si ha sido infiel, perderán su pareja. El tentador, tendrá una nueva pareja.}
procedure rondaTentacion(var l: TArray);
var
  pjaTentada,pteTentador,prob: integer;
  hayTentacion: boolean;
begin
  hayTentacion:= False;

  repeat
    pjaTentada:= random(3) + 1; {Numero aletorio entre 1 y 3}
  until ( (l[pjaTentada*2-1] <> NIL ) and ( l[pjaTentada*2] <> NIL) );

  repeat
    pteTentador:= (random(NUM_PAREJAS)+1) + (NUM_PAREJAS*2);
  until ( l[pteTentador]^.otroParticipante = NIL );

  prob:= random(4); {Numero aletorio entre 0 y 3}
  if prob = 0 then
    hayTentacion:= True;

  if hayTentacion then begin

    prob:= random(2); {Numero aletorio entre 0 y 1}
    if prob = 0 then begin
      crearPareja( l[(pjaTentada*2)-1],l[pteTentador] );
      l[pjaTentada*2]^.otroParticipante:= NIL;
    end
    else begin
      crearPareja( l[pjaTentada*2],l[pteTentador] );
      l[(pjaTentada*2) -1]^.otroParticipante:= NIL;
    end;

  end;

end;


{8. Genera un programa que le pregunte al usuario si quiere jugar una ronda más o no.
    Si el usuario decide que sí, se realizará una ronda más. Si decide que no, se mostrará el estado final de la isla de las tentaciones.}
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
