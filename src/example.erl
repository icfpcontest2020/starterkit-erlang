-module(example).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([ServerUrl, PlayerKey]) ->
    try
        {ok, _} = application:ensure_all_started(inets),
        {ok, _} = application:ensure_all_started(ssl),
        io:format("ServerUrl: ~p; PlayerKey: ~p~n", [ServerUrl, PlayerKey]),
        {ok, {{_, StatusCode, _}, _Headers, Body}} =
            httpc:request(post, {ServerUrl, [], [], PlayerKey}, [], []),
        if 
            StatusCode == 200 -> 
                io:format("Server response: ~p~n", [Body]),
                erlang:halt(0);
            true -> 
                io:format("Unexpected server response:~nHTTP code: ~p~nResponse body: ~p~n", [StatusCode, Body]),
                erlang:halt(2)
        end
    catch
        error:Error -> io:format("Unexpected server response:~n~p", [Error]),
        erlang:halt(1)
    end. 

%%====================================================================
%% Internal functions
%%====================================================================
