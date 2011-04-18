-module(tc_tool).
-author('sonupundir@gmail.com').

-behaviour(application).
-export([start/2, stop/1]).

start(Type, StartArgs) ->
	tc_tool_sup:start_link().
