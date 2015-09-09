-module(ms_app).
-include("ms.hrl").

%% public
-export([
    start/0,
    stop/0
]).

-behaviour(application).
-export([
    start/2,
    stop/1
]).

%% public
-spec start() -> ok | {error, term()}.

start() ->
    application:load(statsderl),
    BaseKey = [element(2, inet:gethostname()), <<".ms">>],
    ok = application:set_env(statsderl, base_key, BaseKey),

    application:load(ms_base),
    Types = application:get_env(ms_base, local_resource_types, []),
    [application:ensure_all_started(App) || App <- Types],

    application:start(?APP).

-spec stop() -> ok | {error, {not_started, ?APP}}.

stop() ->
    application:stop(?APP).

%% application callbacks
-spec start(application:start_type(), term()) -> {ok, pid()}.

start(_StartType, _StartArgs) ->
    ms_sup:start_link().

-spec stop(term()) -> ok.

stop(_State) ->
    ok.
