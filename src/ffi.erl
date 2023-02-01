-module(ffi).
-export([get_os_type/0]).

get_os_type() ->
  case os:type() of
    {win32, _} -> <<"win32">>;
    {unix, _} -> <<"unix">>
  end.