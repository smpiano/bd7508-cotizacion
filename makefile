doc: build/informe.pdf

build:
	-mkdir -p build/images build/schema

build/informe.pdf: build build/images/der.jpeg build/images/rel.jpg doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex

build/images/der.jpeg:
	dia --export=build/images/der.jpeg --filter=jpeg doc/diagramas/der.dia

build/images/rel.jpg: schema-generator
	cp doc/diagramas/rel2.png build/images/

clean:
	rm -rf build
	rm -f informe.pdf

doc-preview: doc build/informe.pdf
	cp build/informe.pdf .
	evince informe.pdf &

schema-generator:
	./createCubrePoliza_pgsql.sh

.PHONY: doc/diagramas/der.dia
