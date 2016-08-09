(* -------------------------------------------------------------------------- *)
(**
 * Partial binding to the core javascript standard library
 *
 * Contributors:
   * Lexifi SAS - https://www.lexifi.com/
 *)
(* -------------------------------------------------------------------------- *)

module JSON: sig
  val stringify: Ojs.t -> string
      [@@js.global "JSON.stringify"]

  val parse: string -> Ojs.t
      [@@js.global "JSON.parse"]
end

val encode_URI_component: string -> string
    [@@js.global]

val decode_URI_component: string -> string
    [@@js.global]

val encode_URI: string -> string
    [@@js.global]

val decode_URI: string -> string
    [@@js.global]

val log_string: string -> unit [@@js.global "console.log"]
val log_any: Ojs.t -> unit [@@js.global "console.log"]
