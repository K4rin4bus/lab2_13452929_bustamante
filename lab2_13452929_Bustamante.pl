% TDA FileSystem - constructor (usa el timestamp, solo para el RF1)
% Predicado: filesystem/6
% Dominio: 
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, [System])
% MetaSecundaria:get_time(TimeStamp)
filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, Content, [Nombre, Drives, Users, CurrentDrive, CurrentUser, Content, TimeStamp]):-
   get_time(TimeStamp).


% TDA FileSystem - constructor (para obtener el timestamp ya creado)
% Predicado: filesystem/7
% Dominio: 
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, TimeStamp, [System])
% MetaSecundaria:
filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, Content, TimeStamp, [Nombre, Drives, Users, CurrentDrive, CurrentUser, Content, TimeStamp]).


% TDA FileSystem - Modificador (modifica lista de drives en el sistema)
% Predicado: setDrives/3
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setDrives(System, UpdatedDrives, UpdatedSystem):-
    filesystem(Nombre, _, Users, CurrentDrive, CurrentUser, Content, TimeStamp, System),
    filesystem(Nombre, UpdatedDrives, Users, CurrentDrive, CurrentUser, Content, TimeStamp, UpdatedSystem).


% TDA FileSystem - Modificador (modifica lista de users en el sistema)
% Predicado: setUsers/3
% Dominio: 
% MetaPrincipal: setUsers(System, UpdatedUsers, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, UpdatedUsers, Content, TimeStamp, UpdatedSystem).
setUsers(System, UpdatedUsers, UpdatedSystem):-
    filesystem(Nombre, Drives, _, CurrentDrive, CurrentUser, Content, TimeStamp, System),
    filesystem(Nombre, Drives, UpdatedUsers, CurrentDrive, CurrentUser, Content, TimeStamp, UpdatedSystem).


% TDA FileSystem - Modificador (modifica CurrentUser, logea usuario en sistema)
% Predicado: setLoginUserInSystem/3
% Dominio: 
% MetaPrincipal: setLoginUserInSystem(System, User, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, Users, CurrentDrive, User, Content, TimeStamp, UpdatedSystem)
setLoginUser(System, User, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, User, Content, TimeStamp, UpdatedSystem).


% TDA FileSystem - Modificador (modifica CurrentUser, deslogea usuario en sistema)
% Predicado: setLogoutUser/2
% Dominio: 
% MetaPrincipal: setLogoutUser(System, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, Users, CurrentDrive, " ", Content, TimeStamp, UpdatedSystem).
setLogoutUser(System, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, " ", Content, TimeStamp, UpdatedSystem).


% TDA FileSystem - Modificador (modifica CurrentDrive en sistema)
% Predicado: setCurrentDrive/3
% Dominio: 
% MetaPrincipal: setCurrentDrive(System, Unidad, UpdatedSystem)
% MetaSecundaria:
setCurrentDrive(System, Unidad, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, _, CurrentUser, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, Unidad, CurrentUser, Content, TimeStamp, UpdatedSystem).


% TDA FileSystem - Modificador (modifica Content en sistema)
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setFolderInSystem(System, Ruta, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, _, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, Ruta, TimeStamp, UpdatedSystem).


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

%========================================================
% TDA  - Pertenencia (revisa si existe elemento en lista)
% Predicado: exists/2
% Dominio: 
% MetaPrincipal: 
% MetaSecundaria:
exists(Elemento, [Cabecera|_]) :- % Base caso, primer elemento de lista
   member(Elemento, Cabecera).

exists(Elemento, [_|RestoListas]) :- % Recursivo caso
   exists(Elemento, RestoListas).

%========================================================




% TDA User - Selector
% Predicado: getUsers/2
% Dominio: 
% MetaPrincipal: getUsers(System, Users)
% MetaSecundaria: filesystem(_, _, Users, _, _, System)
getUsers(System, Users):-
    filesystem(_, _, Users, _, _, _, _, System).


% no pertenece
notExistsUser(User, Users) :-
   \+ member(User, Users).

% pertenece
existsUser(User, Users) :-
   member(User, Users).

% TDA User - Modificador
% Predicado: setAddUserInUsers/3
% Dominio: 
% MetaPrincipal: setAddUserInUsers(Users, User, UpdatedUsers)
% MetaSecundaria: append(Users, [User], UpdatedUsers)
setAddUserInUsers(Users, User, UpdatedUsers):-
    append(Users, [User], UpdatedUsers).

% TDA User - Selector
% Predicado: getCurrentUser/2
% Dominio: 
% MetaPrincipal: getCurrentUser(System, CurrentUser)
% MetaSecundaria: filesystem(_, _, _, _, CurrentUser, _, _, System)
getCurrentUser(System, CurrentUser):-
    filesystem(_, _, _, _, CurrentUser, _, _, System).
    
existeCurrentUser(CurrentUser):-
    CurrentUser \== "".

%========================================================
% TDA Ruta - constructor 
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
setRuta(Nombre, User,[Nombre, User, TimeStamp]):-
     get_time(TimeStamp).

%========================================================
% TDA  Folder - constructor 
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
folder(Nombre, User, [Nombre, User]).


%========================================================
% TDA  File - constructor 
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
file(NombreF, ExtensionF, ContenidoF,[NombreF, ExtensionF, ContenidoF]).




% 
% TDA  
% Predicado: 
% Dominio: 
% MetaPrincipal:
% MetaSecundaria:
% 
% 
 concatenar(String1, String2, Nombre) :-
    string_concat(String1, String2, Nombre).
  
%========================================================
%   Reglas requerimientos funcionales
%========================================================

%RF-1 System
% creando un nuevo sistema con nombre “NewSystem”
% system("NewSystem", S).
system(Nombre, Sistema):-
   filesystem(Nombre, [], [], " ", " ", [], Sistema).

%RF-2 systemAddDrive
% creando la unidad C, con nombre “OS” y capacidad 1000000000 en el sistema “NewSystem”
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2).
systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem):-
    notLetterDriveInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
    drive(Unidad, Nombre, Capacidad, NewDrive),
    getDrives(System, CurrentDrives),
    setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
    setDrives(System, UpdatedDrives, UpdatedSystem).

%RF-3 systemRegister
% creando el usuario "user1"
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2),
% systemRegister(S2, "user1", S3).
systemRegister(System, User, UpdatedSystem):-
    getUsers(System, Users),
    notExistsUser(User, Users), 
    setAddUserInUsers(Users, User, UpdatedUsers),
    setUsers(System, UpdatedUsers, UpdatedSystem).
    
%RF-4 systemLogin
%iniciando sesión con "user1" siempre y cuando exista
%systemLogin(S, "user1", S2).
systemLogin(System, User, UpdatedSystem):-
    getUsers(System, Users),
    existsUser(User, Users),
    setLoginUser(System, User, UpdatedSystem).

%RF-5 systemLogout
% se asume que S tiene sesión iniciada con “user1”
%systemLogout(S, S2).
systemLogout(System, UpdatedSystem):-
    getCurrentUser(System, CurrentUser),
    existeCurrentUser(CurrentUser),
    setLogoutUser(System, UpdatedSystem).

%RF-6 systemSwitchDrive
%Cambiándose a la unidad C, debe existir usuario logeado
%systemSwitchDrive(S, "C", S2).
systemSwitchDrive(System, Unidad, UpdatedSystem):-
    getCurrentUser(System, CurrentUser),
    existeCurrentUser(CurrentUser),
    letterDriveInSystem(Unidad, System),
    setCurrentDrive(System, Unidad, UpdatedSystem).

%RF-7 systemMkdir
%creando la carpeta c1 dentro de la unidad C
%systemMkdir(S, "c1", S2).
%Rutas (List Ruta)
% Type Ruta = (nombreRuta Archivo fechaModificacion)
% Type Archivo = (nombreArchivo contenidoArchivo)
systemMkdir(System, FolderName, UpdatedSystem):-
    getCurrentDrive(System, CurrentDrive), % tomo el drive
    getCurrentUser(System, CurrentUser), % tomo al user
    concatenar(CurrentDrive, FolderName, Nombre),
    setRuta(Nombre, CurrentUser, Ruta),
    setFolderInSystem(System, Ruta, UpdatedSystem).



%usar predicado usemodule para separar codigo
%consult('tda_user.pl'). 
%consult('tda_drive.pl').
%consult('exists.pl').