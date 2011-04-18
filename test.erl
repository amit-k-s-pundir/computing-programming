-module(utility).
-export([rotate/1]).

rotate([H|T]) ->
	T ++ [H].
