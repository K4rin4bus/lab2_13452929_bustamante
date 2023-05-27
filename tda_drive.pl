%TDA_Drive.pl

%========================================================
% TDA Drive - Constructor
% Predicado: drive/3
% Dominio: 
% MetaPrincipal: drive(Unidad, Nombre, Capacidad,[Unidad, Nombre, Capacidad])
drive(Unidad, Nombre, Capacidad,[Unidad, Nombre, Capacidad]).

% TDA Drive - Selector (toma lista de drives del sistema)
% Predicado: getDrives/2
% Dominio: 
% MetaPrincipal: getDrives(System, Drives)
% MetaSecundaria: filesystem(_, Drives, _, _, System).
getDrives(System, Drives):-
    filesystem(_, Drives, _, _, _, _, _, System).

%no existe unidad en sistema
notLetterDriveInSystem(Unidad, System) :-
   filesystem(_, Drives, _, _, _, _, _, System),
    \+ exists(Unidad, Drives). %  \+ es not

%existe unidad en sistema
letterDriveInSystem(Unidad, System) :-
    filesystem(_, Drives, _, _, _, _, _, System),
    exists(Unidad, Drives).


% TDA Drive - Selector (toma currentdrive del sistema)
% Predicado: getCurrentDrive/2
% Dominio: 
% MetaPrincipal: getCurrentDrive(System, CurrentDrive)
% MetaSecundaria:  filesystem(_, _, _, _, CurrentDrive, _, _, System).
getCurrentDrive(System, CurrentDrive):-
    filesystem(_, _, _, CurrentDrive, _, _, _, System).


% TDA Drive - Modificador (agrega drive a lista de drives del sistema)
% Predicado: setAddNewDriveInDrives/3
% Dominio: 
% MetaPrincipal: setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives)
% MetaSecundaria:  append(Drives, [NewDrive], UpdatedDrives)
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives):-
   append(Drives, [NewDrive], UpdatedDrives).