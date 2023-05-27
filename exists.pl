%exists.pl
%========================================================
% Predicado que revisa si existe elemento en lista
% Predicado: exists/2
% Dominio: 
% MetaPrincipal: 
% MetaSecundaria:
exists(Elemento, [Cabecera|_]) :- % Base caso, primer elemento de lista
   member(Elemento, Cabecera).

exists(Elemento, [_|RestoListas]) :- % Recursivo caso
   exists(Elemento, RestoListas).