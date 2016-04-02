Binding in OCaml to Javascript standard library
===============================================

Some technologies such as [js_of_ocaml](https://ocsigen.org/js_of_ocaml)
provides a compiler from OCaml to javascript allowing ocaml developer to use
OCaml to develop such as applications running in a browser or mobile
applications using cordova.

This library aims to provide a binding, using *pure* OCaml type (not using JS
module from js_of_ocaml for example).

## How is this library implemented

[Gen_js_api](https://github.com/lexifi/gen_js_api) is recommended which aims to
provide binding to javascript independently of the ocaml to javascript compiler.
With gen_js_api, you only need to provide the interface (mli file) and
gen_js_api executable outputs the implementation.

## How to use it

Gen_js_api and some files needs the **compiler >= 4.03.0**. See the [gen_js_api
repository](https://github.com/lexifi/gen_js_api) for informations about
compilation.

## Documentation

* core.mli: partial binding to the core javascript standard library.
* dom.mli: binding to the *DOM*.
* jQuery.mli: bindings to jQuery.
* js_date.mli: bindings to the *Date* object.

## To-do

* Documentation

* The entire library structure must be defined.

* We need to unify the styles used for the bindings: classes or private types ?

## License

This library is under LGPL license.

## Maintainers

* Danny Willems
  * Twitter: [@dwillems42](https://twitter.com/dwillems42)
  * Github: https://github.com/dannywillems
  * Email: contact@danny-willems.be
  * Website: [danny-willems.be](https://danny-willems.be)

## Contributors

* Lexifi SAS: Thanks for the initial dom.mli, jQuery.mli and core.mli files and
  the license choice.
  * Website: [Lexifi](https://www.lexifi.com/)
