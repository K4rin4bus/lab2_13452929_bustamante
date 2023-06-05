%========================================================
%                   TDA FileSystem 
%========================================================
% TDA FileSystem - constructor (usa el timestamp, solo para el RF1)
% Predicado: filesystem/6
% Dominio: Nombre (str) x System
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, [System])
% MetaSecundaria:get_time(TimeStamp)
filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, [Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp]):-
   get_time(TimeStamp).

% TDA FileSystem - constructor (para obtener el timestamp ya creado)
% Predicado: filesystem/7
% Dominio: Nombre (str) x System
% MetaPrincipal:filesystem(Nombre, Drives, Users, Content, TimeStamp, [System])
filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, [Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp]).

% TDA FileSystem - Modificador (modifica lista de drives en el sistema)
% Predicado: setDrives/3
% Dominio: Drives(List)
% MetaPrincipal:setDrives(System, UpdatedDrives, UpdatedSystem):-
% MetaSecundaria:filesystem(Nombre, _, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, System),
%    filesystem(Nombre, UpdatedDrives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, UpdatedSystem).
setDrives(System, UpdatedDrives, UpdatedSystem):-
    filesystem(Nombre, _, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, System),
    filesystem(Nombre, UpdatedDrives, Users, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica lista de users en el sistema)
% Predicado: setUsers/3
% Dominio: Users(List)
% MetaPrincipal: setUsers(System, UpdatedUsers, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, UpdatedUsers, Content, TimeStamp, UpdatedSystem).
setUsers(System, UpdatedUsers, UpdatedSystem):-
    filesystem(Nombre, Drives, _, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, System),
    filesystem(Nombre, Drives, UpdatedUsers, CurrentDrive, CurrentUser, CurrentPath, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica CurrentUser, logea usuario en sistema)
% Predicado: setLoginUserInSystem/3
% Dominio: CurrentUser(Str)
% MetaPrincipal: setLoginUserInSystem(System, User, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, Users, CurrentDrive, User, Content, TimeStamp, UpdatedSystem)
setLoginUser(System, User, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, _, CurrentPath, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, User, CurrentPath, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica CurrentUser, deslogea usuario en sistema)
% Predicado: setLogoutUser/2
% Dominio: CurrentUser(Str)
% MetaPrincipal: setLogoutUser(System, UpdatedSystem)
% MetaSecundaria: filesystem(Nombre, Drives, Users, CurrentDrive, _, Content, TimeStamp, System),
%               filesystem(Nombre, Drives, Users, CurrentDrive, " ", Content, TimeStamp, UpdatedSystem).
setLogoutUser(System, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, _, CurrentPath, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, " ", CurrentPath, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica CurrentDrive en sistema)
% Predicado: setCurrentDrive/3
% Dominio: CurrentDrive(Str)
% MetaPrincipal: setCurrentDrive(System, Unidad, UpdatedSystem)
% MetaSecundaria:filesystem(Nombre, Drives, Users, _, CurrentUser, _, Content, TimeStamp, System),
%    filesystem(Nombre, Drives, Users, Unidad, CurrentUser, Unidad, Content, TimeStamp, UpdatedSystem).
setCurrentDrive(System, Unidad, Unidad, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, _, CurrentUser, _, Content, TimeStamp, System),
    filesystem(Nombre, Drives, Users, Unidad, CurrentUser, Unidad, Content, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica Content en sistema desde Mkdir)
% Predicado: setContent/3
% Dominio: CurrentPath(Str) X Content(List)
% MetaPrincipal: setContent(System, NewPath, UpdatedContent, UpdatedSystem):-
% MetaSecundaria:filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, _, _, TimeStamp, System),
%    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, NewPath, UpdatedContent, TimeStamp, UpdatedSystem).
setContent(System, NewPath, UpdatedContent, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, _, _, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, NewPath, UpdatedContent, TimeStamp, UpdatedSystem).

% TDA FileSystem - Modificador (modifica Content en sistema desde Addfile)
% Predicado: setContent/2
% Dominio: Content(List)
% MetaPrincipal: setContent(System, UpdatedContent, UpdatedSystem):-
% MetaSecundaria:filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, _, TimeStamp, System),
%    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, UpdatedContent, TimeStamp, UpdatedSystem).
setContent(System, UpdatedContent, UpdatedSystem):-
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, _, TimeStamp, System),
    filesystem(Nombre, Drives, Users, CurrentDrive, CurrentUser, CurrentPath, UpdatedContent, TimeStamp, UpdatedSystem).

%========================================================
%                   TDA Drive
%========================================================
% TDA Drive - Constructor
% Predicado: drive/3
% Dominio: Unidad(Str), Nombre(Str), Capacidad(num)
% MetaPrincipal: drive(Unidad, Nombre, Capacidad,[Unidad, Nombre, Capacidad])
drive(Unidad, Nombre, Capacidad,[Unidad, Nombre, Capacidad]).

% TDA Drive - Selector (toma lista de drives del sistema)
% Predicado: getDrives/2
% Dominio: System(List), Drives(List)
% MetaPrincipal: getDrives(System, Drives)
% MetaSecundaria: filesystem(_, Drives, _, _, System).
getDrives(System, Drives):-
    filesystem(_, Drives, _, _, _, _, _, _, System).

% TDA Drive - Modificador (agrega drive a lista de drives del sistema)
% Predicado: setAddNewDriveInDrives/3
% Dominio: Drives(List)
% MetaPrincipal: setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives)
% MetaSecundaria:  append(Drives, [NewDrive], UpdatedDrives)
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives):-
   append(Drives, [NewDrive], UpdatedDrives).

%TDA Drive - Pertenencia (no existe unidad en sistema)
% Predicado: notLetterDriveInSystem/1
% Dominio: Drives(List) X Unidad(Str)
% MetaPrincipal: notLetterDriveInSystem(Unidad, System)
% MetaSecundaria: filesystem(_, Drives, _, _, _, _, _, _, System),
%    \+ exists(Unidad, Drives). 
notLetterDriveInSystem(Unidad, System) :-
   filesystem(_, Drives, _, _, _, _, _, _, System),
    \+ exists(Unidad, Drives). %  \+ es not

% TDA Drive - Pertenencia (existe unidad en sistema)
% Predicado: letterDriveInSystem/1
% Dominio: Drives(List) X Unidad(Str)
% MetaPrincipal: letterDriveInSystem(Unidad, System)
% MetaSecundaria: filesystem(_, Drives, _, _, _, _, _, _, System),
%    exists(Unidad, Drives). 
letterDriveInSystem(Unidad, System) :-
    filesystem(_, Drives, _, _, _, _, _, _, System),
    exists(Unidad, Drives).

%========================================================
%                   TDA User
%========================================================
% TDA User - Selector
% Predicado: getUsers/2
% Dominio: System(List) X Users(List)
% MetaPrincipal: getUsers(System, Users)
% MetaSecundaria: filesystem(_, _, Users, _, _, System)
getUsers(System, Users):-
    filesystem(_, _, Users, _, _, _, _, _, System).


% TDA User - Pertenencia (No pertenece)
% Predicado: notExistsUser/1
% Dominio: Users(List) X User(Str)
% MetaPrincipal: notExistsUser(User, Users)
% MetaSecundaria:  \+ member(User, Users).
notExistsUser(User, Users) :-
   \+ member(User, Users).

% TDA User - Pertenencia (Pertenece)
% Predicado: existsUser/1
% Dominio: Users(List) X User(Str)
% MetaPrincipal: existsUser(User, Users)
% MetaSecundaria:  member(User, Users).
existsUser(User, Users) :-
   member(User, Users).

% TDA User - Modificador
% Predicado: setAddUserInUsers/3
% Dominio: Users(List) X User(Str)
% MetaPrincipal: setAddUserInUsers(Users, User, UpdatedUsers)
% MetaSecundaria: append(Users, [User], UpdatedUsers)
setAddUserInUsers(Users, User, UpdatedUsers):-
    append(Users, [User], UpdatedUsers).


%========================================================
%                   TDA CurrentDrive
%========================================================
% TDA CurrentDrive - Selector (toma currentdrive del sistema)
% Predicado: getCurrentDrive/2
% Dominio: CurrentDrive(Str)
% MetaPrincipal: getCurrentDrive(System, CurrentDrive)
% MetaSecundaria:  filesystem(_, _, _, _, CurrentDrive, _, _, System).
getCurrentDrive(System, CurrentDrive):-
    filesystem(_, _, _, CurrentDrive, _, _, _, _, System).

%========================================================
%                   TDA CurrentUser
%========================================================
% TDA CurrentUser - Selector
% Predicado: getCurrentUser/2
% Dominio: CurrentUser(Str)
% MetaPrincipal: getCurrentUser(System, CurrentUser)
% MetaSecundaria: filesystem(_, _, _, _, CurrentUser, _, _, System)
getCurrentUser(System, CurrentUser):-
    filesystem(_, _, _, _, CurrentUser, _, _, _, System).

% TDA CurrentUser - Pertenencia (Pertenece)
% Predicado: existeCurrentUser/1
% Dominio: CurrentUser(Str)
% MetaPrincipal: existsUser(User, Users)
existeCurrentUser(CurrentUser):-
    CurrentUser \== " ".

%========================================================
%                   TDA CurrentPath
%========================================================
% TDA CurrentPath - Selector (toma currentpath del sistema)
% Predicado: getCurrentPath/1
% Dominio: CurrentPath
% MetaPrincipal: getCurrentPath(System, CurrentPath)
% MetaSecundaria:  filesystem(_, _, _, _, _, CurrentPath, _, _, System).
getCurrentPath(System, CurrentPath):-
    filesystem(_, _, _, _, _, CurrentPath, _, _, System).

%========================================================
%                   TDA Content
%========================================================
% TDA Ruta - constructor 
% Predicado: content/5
% Dominio: CurrentDrive(Str), CurrentPath(Str), Archivo(List), Extension(Str), CurrentUser(Str)
% MetaPrincipal: content(CurrentDrive, CurrentPath, Archivo, Extension, CurrentUser, [CurrentDrive, CurrentPath, Archivo, Extension, CurrentUser, TimeStamp]):-
% MetaSecundaria:  get_time(TimeStamp).
content(CurrentDrive, CurrentPath, Archivo, Extension, CurrentUser, [CurrentDrive, CurrentPath, Archivo, Extension, CurrentUser, TimeStamp]):-
    get_time(TimeStamp).

% TDA Content - Selector (toma Content del sistema)
% Predicado: getContent/1
% Dominio: Content
% MetaPrincipal: getContent(System, Content)
% MetaSecundaria:  filesystem(_, _, _, _, _, _, Content, _, System).
getContent(System, Content):-
     filesystem(_, _, _, _, _, _, Content, _, System).

% TDA Content - Modificador ( Modifica Content del sistema)
% Predicado: setAddNewContentInContent/2
% Dominio: Content
% MetaPrincipal: setAddNewContentInContent(NewContent, CurrentContent, UpdatedContent)
% MetaSecundaria:  append(CurrentContent, [NewContent], UpdatedContent).
setAddNewContentInContent(NewContent, CurrentContent, UpdatedContent):-
    append(CurrentContent, [NewContent], UpdatedContent).

%========================================================
%                   TDA File
%========================================================
% TDA Ruta - constructor 
% Predicado: fileCons/3
% Dominio: NombreF(str), ExtensionF(str), ContenidoF(str)
% MetaPrincipal:fileCons(NombreF, ExtensionF, ContenidoF,[NombreF, ExtensionF, ContenidoF]).
fileCons(NombreF, ExtensionF, ContenidoF,[NombreF, ExtensionF, ContenidoF]).


%================================================================
% Pertenencia varios TDA's (revisa si existe elemento en lista)
%================================================================
% Predicado: exists/2
% Dominio: 
% MetaPrincipal: exists(Elemento, [Cabecera|_])
% MetaSecundaria:member(Elemento, Cabecera).
exists(Elemento, [Cabecera|_]) :- % Base caso, primer elemento de lista
   member(Elemento, Cabecera).

exists(Elemento, [_|RestoListas]) :- % Recursivo caso
   exists(Elemento, RestoListas).
%========================================================

concatenar(String1, String2, String3, Resultado) :-
    concat(String1, String2, Temp),    % Concatena String1 y String2 en Temp
    concat(Temp, String3, Resultado).  % Concatena Temp y String3 en Resultado



%========================================================
%   Reglas requerimientos funcionales
%========================================================

%RF-1 System
% creando un nuevo sistema con nombre “NewSystem”
system(Nombre, Sistema):-
   filesystem(Nombre, [], [], " ", " ", " ", [], Sistema).

%RF-2 systemAddDrive
% creando la unidad C, con nombre “OS” y capacidad 1000000000 en el sistema “NewSystem”
systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem):-
    notLetterDriveInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
    drive(Unidad, Nombre, Capacidad, NewDrive),
    getDrives(System, CurrentDrives),
    setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
    setDrives(System, UpdatedDrives, UpdatedSystem).

%RF-3 systemRegister
% creando el usuario "user1"
systemRegister(System, User, UpdatedSystem):-
    getUsers(System, Users),
    notExistsUser(User, Users), 
    setAddUserInUsers(Users, User, UpdatedUsers),
    setUsers(System, UpdatedUsers, UpdatedSystem).

%RF-4 systemLogin
%iniciando sesión con "user1" siempre y cuando exista
systemLogin(System, User, UpdatedSystem):-
    getUsers(System, Users),
    existsUser(User, Users),
    setLoginUser(System, User, UpdatedSystem).

%RF-5 systemLogout
% se asume que tiene sesión iniciada con “user1”
systemLogout(System, UpdatedSystem):-
    getCurrentUser(System, CurrentUser),
    existeCurrentUser(CurrentUser),
    setLogoutUser(System, UpdatedSystem).

%RF-6 systemSwitchDrive
%Cambiándose a la unidad C, debe existir usuario logeado
systemSwitchDrive(System, Unidad, UpdatedSystem):-
    getCurrentUser(System, CurrentUser),
    existeCurrentUser(CurrentUser),
    letterDriveInSystem(Unidad, System),
    setCurrentDrive(System, Unidad, Unidad, UpdatedSystem).
    
%RF-7 systemMkdir
%creando la carpeta c1 dentro de la unidad C
systemMkdir(System, FolderName, UpdatedSystem):-
    getCurrentUser(System, CurrentUser), % tomo al user actual
    getCurrentDrive(System, CurrentDrive), % tomo al drive actual
    getCurrentPath(System, CurrentPath), % tomo el path actual
    
    concatenar(CurrentPath, "/", FolderName, NewPath),
    content(CurrentDrive, NewPath, [], " ", CurrentUser, NewContent),
    getContent(System, CurrentContent),
    setAddNewContentInContent(NewContent, CurrentContent, UpdatedContent),
    setContent(System, NewPath, UpdatedContent, UpdatedSystem).

%RF-8 systemCd


%RF-9 systemAddFile
%creación de un archivo de tipo txt llamado foo.txt con el contenido “hello world”
file(NomFile, ContentFile, NewFile):-
    fileCons(NomFile, " ", ContentFile, NewFile).

systemAddFile(System, NewFile, UpdatedSystem):-
    getCurrentUser(System, CurrentUser), % tomo al user actual
    getCurrentDrive(System, CurrentDrive), % tomo al drive actual
    getCurrentPath(System, CurrentPath), % tomo el path actual
    NewPath = CurrentPath,
    %revisar si esxiste archivo en ruta (se reemplaza)
    getContent(System, CurrentContent),
    content(CurrentDrive, CurrentPath, NewFile, " ", CurrentUser, NewContent),
    setAddNewContentInContent(NewContent, CurrentContent, UpdatedContent),
    setContent(System, NewPath, UpdatedContent, UpdatedSystem).
