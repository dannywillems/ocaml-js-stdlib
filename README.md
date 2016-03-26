Binding to Javascript standard library in OCaml
===============================================

Some technologies such as [js_of_ocaml](https://ocsigen.org/js_of_ocaml)
provides a compiler from OCaml to javascript allowing ocaml developer to use
OCaml to develop such as applications running in a browser or mobile
applications using cordova.

This library aims to provide a binding, using *pure* OCaml type (not using JS
module from js_of_ocaml for example).

## How is this library implemented

We try to use [gen_js_api](https://github.com/lexifi/gen_js_api) which aims to
provide binding to javascript independently of the ocaml to javascript compiler.
With gen_js_api, you only need to provide the interface (mli file) and
gen_js_api executable outputs the implementation.

## How to contribute

This library is on a very early stage of development. It is developed when we
need javascript functions provided in the standard library. Do not hesitate to
contribute.

## Maintainers

* Danny Willems
  * Twitter: [@dwillems42](https://twitter.com/dwillems42)
  * Github: https://github.com/dannywillems
  * Email: contact@danny-willems.be
  * Website: [danny-willems.be](https://danny-willems.be)
