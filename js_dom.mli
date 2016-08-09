(* -------------------------------------------------------------------------- *)
(**
 * Binding to the DOM.
 *
 * Contributors:
   * Lexifi SAS - https://www.lexifi.com/
 *)
(* -------------------------------------------------------------------------- *)

module File: sig
  type t
end

module Geolocation: sig
  type t

  type coords =
    {
      latitude: float;
      longitude: float;
      accuracy: float;
      altitude: float;
      altitude_accuracy: float;
      heading: float;
      speed: float;
    }

  type data =
    {
      coords: coords;
      timestamp: float;
    }

  val get_current_position: t -> (data -> unit) -> unit [@@js.call]
end

module Navigator: sig
  type t

  val app_code_name: t -> string
  val app_name: t -> string
  val app_version: t -> string
  val cookie_enabled: t -> bool
  val geolocation: t -> Geolocation.t
  val language: t -> string
  val on_line: t -> bool
  val platform: t -> string
  val product: t -> string
  val user_agent: t -> string
  val java_enabled: t -> bool [@@js.call]
end

module Screen: sig
  type t

  val avail_height: t -> int
  val avail_width: t -> int
  val color_depth: t -> int
  val height: t -> int
  val width: t -> int
end

module Location: sig
  type t

  val get_hash: unit -> string [@@js.get "location.hash"]
  val set_hash: string -> unit [@@js.set "location.hash"]

  val host: t -> string
  val set_host: t -> string -> unit

  val hostname: t -> string
  val set_hostname: t -> string -> unit

  val href: unit -> string [@@js.get "location.href"]
  val set_href: string -> unit [@@js.set "location.href"]

  val pathname: t -> string
  val set_pathname: t -> string -> unit

  val port: t -> string
  val set_port: t -> string -> unit

  val protocol: t -> string
  val set_protocol: t -> string -> unit

  val search: t -> string
  val set_search: t -> string -> unit

  val assign: t -> string -> unit [@@js.call]
  val reload: t -> ?force:bool -> unit -> unit
  val replace: t -> string -> unit [@@js.call]
end

module Event: sig
  class event: Ojs.t ->
    object
      inherit Ojs.obj
      method bubbles: bool
      method cancelable: bool
      method current_target: Ojs.t
      method event_phase: [ `Capturing_phase [@js 1]
                          | `At_target [@js 2]
                          | `Bubbling_phase [@js 3]
                          ] [@js.enum]
      method target: Ojs.t
      method time_stamp: float
      method type_: string
      method prevent_default: unit
      method stop_immediate_propagation: unit
      method stop_propagation: unit
    end

  class mouse_event: Ojs.t ->
    object
      inherit event
      method alt_key: bool
      method button: int
      method client_x: int
      method client_y: int
      method ctrl_key: bool
      method detail: int
      method meta_key: bool
      method related_target: Ojs.t
      method screen_x: int
      method screen_y: int
      method shift_key: bool
      method which: int
    end

  class keyboard_event: Ojs.t ->
    object
      inherit event
      method alt_key: bool
      method ctrl_key: bool
      method char_code: int
      method key: string
      method key_code: int
      method location: [ `Standard [@js 0]
                       | `Left [@js 1]
                       | `Right [@js 2]
                       | `Numpad [@js 3]
                       ] [@js.enum]
      method meta_key: bool
      method shift_key: bool
      method which: int
    end

  class hash_change_event: Ojs.t ->
    object
      inherit event
      method new_URL: string
      method old_URL: string
    end

  class page_transition_event: Ojs.t ->
    object
      inherit event
      method persisted: bool
    end

  class focus_event: Ojs.t ->
    object
      inherit event
      method related_target: Ojs.t
    end

  class animation_event: Ojs.t ->
    object
      inherit event
      method animation_name: string
      method elapsed_time: float
    end

  class transition_event: Ojs.t ->
    object
      inherit event
      method property_name: string
      method elapsed_time: float
    end

  class wheel_event: Ojs.t ->
    object
      inherit event
      method delta_x: int
      method delta_y: int
      method delta_z: int
      method delta_mode: int
    end

  class message_event: Ojs.t ->
    object
      inherit event
      method data: Ojs.t
      method origin: string
    end

  class file_event: Ojs.t ->
    object
      inherit event
    end

  type _ t =
    | Click: mouse_event t [@js "click"]
    | DblClick: mouse_event t [@js "dblclick"]
    | MouseDown: mouse_event t [@js "mousedown"]
    | MouseEnter: mouse_event t [@js "mouseenter"]
    | MouseLeave: mouse_event t [@js "mouseleave"]
    | MouseMove: mouse_event t [@js "mousemove"]
    | MouseOut: mouse_event t [@js "mouseout"]
    | MouseOver: mouse_event t [@js "mouseover"]
    | MouseUp: mouse_event t [@js "mouseup"]
    | KeyDown: keyboard_event t [@js "keydown"]
    | KeyPress: keyboard_event t [@js "keypress"]
    | KeyUp: keyboard_event t [@js "keyup"]
    | HashChange: hash_change_event t [@js "hashchange"]
    | Load: event t [@js "load"]
    | Message: message_event t [@js "message"]
    | Resize: event t [@js "resize"]
    | LoadEnd: file_event t [@js "loadend"]
    | Change: event t [@js "change"]
          [@@js.enum]

  [@@@js.stop]
  type 'a callback

  val wrap_callback: 'a t -> ('a -> unit) -> 'a callback

  class listener: Ojs.t ->
    object
      inherit Ojs.obj
      method add_event_listener: 'a. 'a t -> ('a -> unit) -> bool -> unit
      method add_removable_event_listener: 'a. 'a t -> ('a -> unit) -> bool -> 'a callback
      method remove_event_listener: 'a. 'a t -> 'a callback -> bool -> unit
    end
  [@@@js.start]

  [@@@js.implem
  type 'a callback = Ojs.t

  let callback_to_js: 'a callback -> Ojs.t = fun x -> x

  let wrap_callback_gen (event_of_js:Ojs.t -> 'a) (f:'a -> unit) : 'a callback =
    Ojs.fun_to_js 1 (fun x -> f (event_of_js x))

  let wrap_callback (type a) (ev:a t) (f:a -> unit) : a callback =
    match ev with
    | Click -> wrap_callback_gen mouse_event_of_js f
    | DblClick -> wrap_callback_gen mouse_event_of_js f
    | MouseDown -> wrap_callback_gen mouse_event_of_js f
    | MouseEnter -> wrap_callback_gen mouse_event_of_js f
    | MouseLeave -> wrap_callback_gen mouse_event_of_js f
    | MouseMove -> wrap_callback_gen mouse_event_of_js f
    | MouseOut -> wrap_callback_gen mouse_event_of_js f
    | MouseOver -> wrap_callback_gen mouse_event_of_js f
    | MouseUp -> wrap_callback_gen mouse_event_of_js f
    | KeyDown -> wrap_callback_gen keyboard_event_of_js f
    | KeyPress -> wrap_callback_gen keyboard_event_of_js f
    | KeyUp -> wrap_callback_gen keyboard_event_of_js f
    | HashChange -> wrap_callback_gen hash_change_event_of_js f
    | Load -> wrap_callback_gen event_of_js f
    | Message -> wrap_callback_gen message_event_of_js f
    | Resize -> wrap_callback_gen event_of_js f
    | LoadEnd -> wrap_callback_gen file_event_of_js f
    | Change -> wrap_callback_gen event_of_js f

  class listener (x:Ojs.t) =
    object(this)
      inherit Ojs.obj x
      method add_removable_event_listener: 'a. 'a t -> ('a -> unit) -> bool -> 'a callback = fun ev f b ->
        let cb = wrap_callback ev f in
        ignore (Ojs.call x "addEventListener"
                  [| t_to_js ev; callback_to_js cb; Ojs.bool_to_js b |]);
        cb
      method add_event_listener: 'a. 'a t -> ('a -> unit) -> bool -> unit = fun ev f b ->
        ignore (this # add_removable_event_listener ev f b)
      method remove_event_listener: 'a. 'a t -> 'a callback -> bool -> unit = fun ev f b ->
        ignore (Ojs.call x "removeEventListener"
                  [| t_to_js ev; callback_to_js f; Ojs.bool_to_js b |])
    end
  ]
end

type bounding_rect =
  {
    width: int;
    height: int;
    top: int;
    right: int;
    bottom: int;
    left: int;
  }

type bounding_box =
  {
    width: int;
    height: int;
    x: int;
    y: int;
  }

class css_style_declaration: Ojs.t ->
  object
    inherit Ojs.obj
    method cssText: string
    method length: int

    method get_property_value: string -> string [@@js.call]
    method remove_property: string -> unit [@@js.call]
    method set_property: string -> string -> unit [@@js.call]
    method item: int -> string [@@js.call]
  end

class node: Ojs.t ->
  object
    inherit Ojs.obj
    method child_nodes: node list
    method first_child: node option
    method last_child: node option
    method next_sibling: node option
    method inner_text : string
    method text_content: string
    method node_name: string
    method node_type: [ `Element [@js 1]
                      | `Attribute [@js 2]
                      | `Text [@js 3]
                      | `CData [@js 4]
                      | `Processing_instruction [@js 7]
                      | `Comment [@js 8]
                      | `Document [@js 9]
                      | `Document_type [@js 10]
                      | `Document_fragment [@js 11]
                      ] [@js.enum]
    method node_value: string option
    method parent_node: node option
    method previous_sibling: node option
    method attributes: attribute list
    method set_attribute: string -> string -> unit
    method get_attribute: string -> string option
    method owner_document: document option
    method clone_node: node -> ?deep:bool -> unit -> node
    method has_attributes: bool [@@js.call]
    method has_child_nodes: bool [@@js.call]
    method insert_before: new_child:node -> ref_child:node option -> unit
    method is_supported: string -> string -> bool
    method normalize: unit
    method append_child: node -> unit [@@js.call]
    method remove_child: node -> unit [@@js.call]
    method replace_child: new_child:node -> old_child:node -> unit
    method get_element_by_id: string -> element option [@@js.call]
    method get_elements_by_tag_name: string -> element list [@@js.call]
    method get_elements_by_class_name: string -> element list [@@js.call]
    method query_selector_all: string -> element list [@@js.call]
    method query_selector: string -> element option [@@js.call]
  end
and document: Ojs.t ->
  object
    inherit node
    method cookie: string
    method set_cookie: string -> unit
    method open_: ?mime_type:string -> ?history_mode:string -> unit -> unit [@@js.call "open"]
    method write: string -> unit [@@js.call]
    method writeln: string -> unit [@@js.call]
    method close: unit
    method create_element: string -> element [@@js.call]
    method create_element_ns: string -> string -> element [@@js.call "createElementNS"]
    method set_title: string -> unit
    method body: element
  end
and attribute: Ojs.t ->
  object
    inherit node
  end
and element: Ojs.t ->
  object
    inherit node
    inherit Event.listener

    method get_bounding_client_rect: bounding_rect [@@js.call]
    method style: css_style_declaration

    method set_text_content: string -> unit
    method getBBox: bounding_box [@@js.call]

    method inner_HTML : string
  end
and window: Ojs.t ->
  object
    inherit Event.listener
    method closed: bool
    method default_status: string
    method set_default_status: string -> unit
    method document: document
    method frame_element: html_iframe_element option
    method frames: element list
    method history: history
    method inner_height: int
    method inner_width: int
    method length: int
    method location: Location.t
    method name: string
    method set_name: string -> unit
    method navigator: Navigator.t
    method opener: window
    method set_opener: window -> unit
    method outer_height: int
    method outer_width: int
    method page_x_offset: int
    method page_y_offset: int
    method parent: window
    method screen: Screen.t
    method screen_left: int
    method screen_top: int
    method screen_x: int
    method screen_y: int
    method status: string
    method set_status: string -> unit
    method top: window
    method alert: string -> unit [@@js.call]
    method atob: string -> string
    method btoa: string -> string
    method blur: unit
    method close: unit
    method confirm: string -> bool [@@js.call]
    method focus: unit
    method move_by: int -> int -> unit
    method move_to: int -> int -> unit
    method open_: ?url:string -> ?name:string -> ?features:string -> ?replace:bool -> unit -> unit
    method print: unit
    method prompt: string -> string -> string option
    method resize_by: int -> int -> unit
    method resize_to: int -> int -> unit
    method scroll_by: int -> int -> unit
    method scroll_to: int -> int -> unit
    method clear_interval: int -> unit [@@js.call]
    method set_interval: (unit -> unit) -> int -> int
    method clear_timeout: int -> unit [@@js.call]
    method set_timeout: (unit -> unit) -> int -> int
    method async: ((unit -> unit) -> unit) option
    method stop: unit
    method local_storage: storage option
    method session_storage: storage option
    method post_message: Ojs.t -> string -> unit
    method request_animation_frame: ((unit -> unit) -> unit) option
  end
and storage: Ojs.t ->
  object
    inherit Ojs.obj
    method length: int
    method key: int -> string option
    method get_item: string -> string option
    method set_item: string -> string -> unit
    method remove_item: string -> unit
    method clear: unit
  end
and history: Ojs.t ->
  object
    inherit Ojs.obj
    method length: int
    method back: unit
    method forward: unit
    method go: ([`Offset of int | `Url of string] [@js.union]) -> unit
    method replace_state: Ojs.t -> string -> string -> unit
    method push_state: Ojs.t -> string -> string -> unit
  end
and html_element: Ojs.t ->
  object
    inherit element
    method hidden: bool
    method set_hidden: bool -> unit
  end
and html_iframe_element: Ojs.t ->
  object
    inherit html_element
    method content_document: document option
    method content_window: window option
    method src: string
    method set_src: string -> unit
    method height: string
    method set_height: string -> unit
    method width: string
    method set_width: string -> unit
    method name: string
    method set_name: string -> unit
    method scrolling: [`Auto [@js "auto"] | `Yes [@js "yes"] | `No [@js "no"]] [@js.enum]
    method set_scrolling: ([`Auto [@js "auto"] | `Yes [@js "yes"] | `No [@js "no"]] [@js.enum]) -> unit
  end
and html_input_element: Ojs.t ->
  object
    inherit html_element
    method files: File.t list
    method get_type: string
    method set_type: string -> unit
  end

module Svg : sig
  class svg_element: Ojs.t ->
    object
      inherit element
    end

  class svg_length: Ojs.t ->
    object
      inherit Ojs.obj

      method unit_type: int
      method value: float
      method value_as_string: string
      method value_in_specified_units: float
    end

  class svg_animated_length: Ojs.t ->
    object
      inherit Ojs.obj

      method anim_val: svg_length
      method base_val: svg_length
    end

  type svg_path_seg_type =
    | Unknown [@js 0]
    | Close_path [@js 1]
    | Moveto_abs [@js 2]
    | Moveto_rel [@js 3]
    | Lineto_abs [@js 4]
    | Lineto_rel [@js 5]
    | Curveto_cubic_abs [@js 6]
    | Curveto_cubic_rel [@js 7]
    | Curveto_quadratic_abs [@js 8]
    | Curveto_quadratic_rel [@js 9]
    [@@js.enum]

  class svg_path_seg: Ojs.t ->
    object
      inherit Ojs.obj

      method x: float
      method y: float
      method x1: float
      method y1: float
      method x2: float
      method y2: float

      method path_seg_type: svg_path_seg_type
      method path_seg_type_as_letter: string
    end

  class svg_path_seg_list: Ojs.t ->
    object
      inherit Ojs.obj

      method number_of_items: int
      method get_item: int -> svg_path_seg [@@js.call]
      method insert_item_before: svg_path_seg -> int -> unit [@@js.call]
      method replace_item: svg_path_seg -> int -> unit [@@js.call]
      method remove_item: int -> unit [@@js.call]
      method append_item: svg_path_seg -> unit [@@js.call]
    end

  class svg_animated_path_data: Ojs.t ->
    object
      inherit Ojs.obj

      method path_seg_list: svg_path_seg_list
      method normalized_path_seg_list: svg_path_seg_list
      method animated_path_seg_list: svg_path_seg_list
      method animated_normalized_path_seg_list: svg_path_seg_list
    end

  class svg_path_element: Ojs.t ->
    object
      inherit svg_element
      inherit svg_animated_path_data

      method create_close_path: unit -> svg_path_seg [@@js.call "createSVGPathSegClosePath"]
      method create_moveto_abs: float -> float -> svg_path_seg [@@js.call "createSVGPathSegMovetoAbs"]
      method create_moveto_rel: float -> float -> svg_path_seg [@@js.call "createSVGPathSegMovetoRel"]
      method create_lineto_abs: float -> float -> svg_path_seg [@@js.call "createSVGPathSegLinetoAbs"]
      method create_lineto_rel: float -> float -> svg_path_seg [@@js.call "createSVGPathSegLinetoRel"]
    end
end

module FileReader: sig
  class filereader: Ojs.t ->
    object
      inherit Event.listener
      method ready_state: [`EMPTY [@js 0] | `LOADING [@js 1] | `DONE [@js 2]] [@js.enum]
      method result: string
      method read_as_text: File.t -> unit
    end

  val create: unit -> filereader [@@js.new "FileReader"]
end

val window: window
val document: document

module HTMLInputElement: sig
  val create: unit -> html_input_element
      [@@js.custom

  let create () =
    let elt = document # create_element "input" in
    new html_input_element (elt # to_js)
]
end
