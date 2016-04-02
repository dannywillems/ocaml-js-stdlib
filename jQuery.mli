(* -------------------------------------------------------------------------- *)
(**
 * Binding to jQuery library.
 *
 * Contributors:
   * Lexifi SAS - https://www.lexifi.com/
 *)
(* -------------------------------------------------------------------------- *)

type t

val t_to_js: t -> Ojs.t [@@js.cast]
val t_of_js: Ojs.t -> t [@@js.cast]

val selector: string -> t
    [@@js.global "jQuery"]
(** Either select a set of elements from the current document, or
    create a new element (if given a string such as "<div>". *)

val wrap: Ojs.t -> t [@@js.global "jQuery"]

val explode: t -> t list
    [@@js.custom
let explode x = Ojs.list_of_js wrap x
    ]

val elements: t -> Dom.element list
    [@@js.custom
let elements node = Ojs.list_of_js (fun x -> new Dom.element x) node
    ]

val contents: t -> t [@@js.call]

val parent: t -> t [@@js.call]

val children: t -> t [@@js.call]

val hide: t -> unit
val show: t -> unit

val prop: t -> string -> Ojs.t [@@js.call]
val set_prop: t -> string -> ([`String of string | `Int of int | `Bool of bool | `Any of Ojs.t] [@js.union]) -> unit [@@js.call "prop"]

val data: t -> string -> Ojs.t [@@js.call]
val set_data: t -> string -> Ojs.t -> unit [@@js.call "data"]

val attr: t -> string -> string option [@@js.call]
val set_attr: t -> string -> string -> unit [@@js.call "attr"]
val remove_attr: t -> string -> unit [@@js.call]

val text: t -> string [@@js.call]
val set_text: t -> string -> unit [@@js.call "text"]

val height: t -> int [@@js.call]
val set_height: t -> ([`String of string | `Int of int] [@js.union]) -> unit [@@js.call "height"]

val width: t -> int [@@js.call]
val set_width: t -> ([`String of string | `Int of int] [@js.union]) -> unit [@@js.call "width"]

val string_value: t -> string [@@js.call "val"]
val set_string_value: t -> string -> unit [@@js.call "val"]

val add_class: t -> string -> unit [@@js.call]
val remove_class: t -> string -> unit [@@js.call]

val css: t -> string -> Ojs.t [@@js.call]

val set_css_value: t -> string -> ([`String of string | `Float of float] [@js.union]) -> unit [@@js.call "css"]

val set_css: t -> Ojs.t -> unit [@@js.call "css"]

val find: t -> string -> t list
    [@@js.custom
val find: t -> string -> t [@@js.call "find"]

let find x sel = explode (find x sel)
    ]

val append: t -> (t list [@js.variadic]) -> unit [@@js.call]
val prepend: t -> (t list [@js.variadic]) -> unit [@@js.call]
val after: t -> t -> unit [@@js.call]
val before: t -> t -> unit [@@js.call]

val detach: t -> unit [@@js.call]

val empty: t -> unit [@@js.call]

val clone: t -> t [@@js.call]

val html: t -> string [@@js.call "html"]
val set_html: t -> string -> unit [@@js.call "html"]

val menu: t -> unit [@@js.call]

module Event : sig
  type t

  val page_x: t -> float
  val page_y: t -> float
  val type_: t -> string
  val target: t -> Ojs.t
  val which: t -> int
  val stop_propagation: t -> unit [@@js.call]
  val prevent_default: t -> unit [@@js.call]
  val original_event: t -> t
  val wheel_delta: t -> float
end

val on: t -> string -> (Event.t -> unit) -> unit
val off: t -> string -> unit

val trigger: t -> string -> unit [@@js.call]

module Dialog: sig
  type button

  val button:
    text:string ->
    click:(unit -> unit) ->
    unit -> button
    [@@js.builder]

  type settings

  val settings:
    ?modal:bool ->
    ?title:string ->
    ?buttons:button list ->
    unit -> settings
    [@@js.builder]
end

module UI : sig

  module Datepicker : sig
    type settings

    val settings:
      ?date_format:string ->
      unit -> settings
      [@@js.builder]
  end

  val datepicker: t -> Datepicker.settings -> unit
end

val dialog: t -> ([`Dialog of Dialog.settings | `String of string] [@js.union]) -> unit

val focus: t -> unit

val remove: t -> unit

module Ajax: sig
  type settings
  (** The type describing all settings of an AJAX call. *)

  type t
  (** Corresponds to jQuery's jqXHR object. *)

  val settings:
    ?async:bool ->
    ?cache:bool ->
    ?complete:(t -> string -> unit) ->
    ?error:(t -> string -> string -> unit) ->
    ?success:(Ojs.t -> string -> t -> unit) ->
    ?data:Ojs.t -> ?data_type:string ->
    ?meth:([`GET | `POST | `PUT] [@js "method"] [@js.enum]) ->
    ?content_type:string ->
    ?url:string ->
    unit -> settings
      [@@js.builder]

  val run: settings -> unit
      [@@js.global "jQuery.ajax"]

  val response_text: t -> string

  val status: t -> int
end

module Notify: sig
  type options

  type message = {msg: string}

  val options:
    ?speed:int ->
    ?expires:int ->
    ?stack:([`above | `below] [@js.enum]) ->
    ?custom:bool ->
    ?queue:bool ->
    ?click:(Event.t -> unit) ->
    unit -> options
      [@@js.builder]

  val notify: t -> ?params:([`Create of (string * message) [@js "create"]] [@js.enum]) -> ?options:options -> unit -> unit
end
