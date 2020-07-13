-module(example).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([ServerUrl, PlayerKey]) ->
    {ok, _} = application:ensure_all_started(inets),
    {ok, _} = application:ensure_all_started(ssl),
    io:format("ServerUrl: ~p~n", [ServerUrl]),
    io:format("PlayerKey: ~p~n", [PlayerKey]),
    URL = ServerUrl,
    {ok, {{_, 200, _}, _Headers, Body}} =
        httpc:request(post, {ServerUrl, [], [], PlayerKey}, [], []),
    io:format("~p~n", [Body]),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================
