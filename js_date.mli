class date : Ojs.t ->
  object
    inherit Ojs.obj

    method get_date                 : int
    method get_day                  : int
    method get_full_year            : int
    method get_hours                : int
    method get_milliseconds         : int
    method get_minutes              : int
    method get_month                : int
    method get_secondes             : int
    method get_time                 : int
    method get_timezone_offset      : int
    method get_UTC_date             : int
    method get_UTC_day              : int
    method get_UTC_full_year        : int
    method get_UTC_hours            : int
    method get_UTC_milliseconds     : int
    method get_UTC_minutes          : int
    method get_UTC_month            : int
    method get_UTC_seconds          : int
    (* DEPRECATED *)
    (* method get_year                 : int *)

    method now                      : int
    method parse                    : string -> int

    method set_date                 : int -> unit
    [@@js.set "setDate"]
    method set_day                  : int -> unit
    [@@js.set "setDay"]
    method set_full_year            : int -> unit
    [@@js.set "setFullYear"]
    method set_hours                : int -> unit
    [@@js.set "setHours"]
    method set_milliseconds         : int -> unit
    [@@js.set "setMilliseconds"]
    method set_minutes              : int -> unit
    [@@js.set "setMinutes"]
    method set_month                : int -> unit
    [@@js.set "setMonth"]
    method set_secondes             : int -> unit
    [@@js.set "setSecondes"]
    method set_time                 : int -> unit
    [@@js.set "setTime"]
    method set_timezone_offset      : int -> unit
    [@@js.set "setTimezoneOffset"]
    method set_UTC_date             : int -> unit
    [@@js.set "setUTCDate"]
    method set_UTC_day              : int -> unit
    [@@js.set "setUTCDay"]
    method set_UTC_full_year        : int -> unit
    [@@js.set "setUTCFullYear"]
    method set_UTC_hours            : int -> unit
    [@@js.set "setUTCHours"]
    method set_UTC_milliseconds     : int -> unit
    [@@js.set "setUTCMilliseconds"]
    method set_UTC_minutes          : int -> unit
    [@@js.set "setUTCMinutes"]
    method set_UTC_month            : int -> unit
    [@@js.set "setUTCMonth"]
    method set_UTC_seconds          : int -> unit
    [@@js.set "setUTCSeconds"]
    (* DEPRECATED *)
    (* method set_year                 : int -> unit *)

    method to_date_string           : string
    method to_ISO_string            : string
    method to_JSON                  : string
    method to_locale_date_string    : string
    method to_locale_time_string    : string
    method to_locale_string         : string
    method to_string                : string
    method to_time_string           : string
    method to_UTC_string            : string
    method utc                      : int
    [@@js.call "UTC"]
    method value_of                 : int
  end

val date                            : unit      -> date
[@@js.new "Date"]
val date_milli                      : int       -> date
[@@js.new "Date"]
val date_str                        : string    -> date
[@@js.new "Date"]
val date_full                       : int -> int -> int -> int -> int -> int ->
                                      int -> date
[@@js.new "Date"]

val date_to_js : date -> Ojs.t
val date_of_js : Ojs.t -> date
