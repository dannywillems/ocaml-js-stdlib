MLI_FILE		= core.mli \
				  dom.mli \
				  jQuery.mli \
				  js_date.mli

CC				= ocamlc
PACKAGES		= -package gen_js_api

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))

all: $(ML_FILE)

%.ml: %.mli
	ocamlfind gen_js_api/gen_js_api $<
	ocamlfind $(CC) -c $(PACKAGES) $<
	ocamlfind $(CC) -c $(PACKAGES) $@

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(ML_FILE)

re: clean all
