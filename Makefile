################################################################################
MLI_FILE		= 	js_core.mli \
					js_dom.mli \
					jQuery.mli \
					js_date.mli

## Name which will be used in -package with ocamlfind
LIB_NAME		= ocaml-js-stdlib
################################################################################

################################################################################
CC				= ocamlc
PACKAGES		= -package gen_js_api

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))
CMA_FILE		= $(LIB_NAME).cma
################################################################################

################################################################################
all: build

%.ml: %.mli
	ocamlfind gen_js_api/gen_js_api $<
	ocamlfind $(CC) -c $(PACKAGES) $<
	ocamlfind $(CC) -c $(PACKAGES) $@

build: $(ML_FILE)
	ocamlfind $(CC) -a -o $(CMA_FILE) $(CMO_FILE)

install: build
	ocamlfind install $(LIB_NAME) META $(CMA_FILE) $(CMI_FILE)

remove:
	ocamlfind remove $(LIB_NAME)

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(ML_FILE) $(CMA_FILE)

re: clean all
################################################################################
