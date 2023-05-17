% TDA FileSystem - constructor
% usa el timestamp, solo para el RF1
% Predicado: filesystem/4
% Dominio: 
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, [System])
% MetaSecundaria:get_time(TimeStamp)
filesystem(Nombre, Drives, Users, Content, [Nombre, Drives, Users, Content, TimeStamp]) :-
   get_time(TimeStamp).

% TDA FileSystem - constructor
% para obtener el timestamp ya creado
% Predicado: filesystem/5
% Dominio: 
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, TimeStamp, [System])
% MetaSecundaria:
filesystem(Nombre, Drives, Users, Content, TimeStamp, [Nombre, Drives, Users, Content, TimeStamp]).


% TDA FileSystem - Modificador
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setDrives(System, UpdatedDrives, UpdatedSystem):-
    filesystem(Nombre, _, Users, Content, TimeStamp, System),
    filesystem(Nombre, UpdatedDrives, Users, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador
% Predicado: setAddUser/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setUsers(System, UpdatedUsers, UpdatedSystem):-
	filesystem(Nombre, Drives, _, Content, TimeStamp, System),
    filesystem(Nombre, Drives, UpdatedUsers, Content, TimeStamp, UpdatedSystem).


% TDA Drive - Constructor
% Predicado: drive/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
drive(Unidad, Nombre, Capacidad,[Unidad, Nombre, Capacidad]).

% TDA Drive - Selector
% Predicado: getDrives/2
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
getDrives(System, Drives):-
    filesystem(_, Drives, _, _, System).

% TDA Drive - Modificador
% Predicado: setAddNewDriveInDrives/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives) :-
   append(Drives, [NewDrive], UpdatedDrives).


% TDA User - Modificador
% Predicado: setAddUser/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setAddUser(System, User, UpdatedSystem):-
	getUsers(System, Users),
    setAddUserInUsers(Users, User, UpdatedUsers),
    setUsers(System, UpdatedUsers, UpdatedSystem).

% TDA User - Selector
% Predicado: getUsers/2
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
getUsers(System, Users):-
    filesystem(_, _, Users, _, System).

% TDA User - Modificador
% Predicado: setAddUserInUsers/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setAddUserInUsers(Users, User, UpdatedUsers):-
	append(Users, [User], UpdatedUsers).


%RF-1 System
% creando un nuevo sistema con nombre “NewSystem”
% system("NewSystem", S).
system(Nombre, Sistema) :-
   filesystem(Nombre, [], [], [], Sistema).


%RF-2 systemAddDrive
% creando la unidad C, con nombre “OS” y capacidad 1000000000 en el sistema “NewSystem”
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2).
systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem) :-
    %letterDoesntExistsInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
	drive(Unidad, Nombre, Capacidad, NewDrive),
    getDrives(System, CurrentDrives),
 	setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
	setDrives(System, UpdatedDrives, UpdatedSystem).

