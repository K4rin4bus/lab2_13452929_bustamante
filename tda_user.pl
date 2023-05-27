%tda_user.pl
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