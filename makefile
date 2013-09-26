doc: build/informe.pdf

build:
	-mkdir -p build
	-mkdir -p build/images

build/informe.pdf: build build/images/der.png doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex

#build/images/der.png: build docs/diagramas/der.dia
build/images/der.png: doc/diagramas/der.dia
	dia --export=build/images/der.png --filter=png doc/diagramas/der.dia

#build/images/rel.png: build docs/diagramas/rel.dia
#	dia --export=build/images/rel.png --filter=png doc/diagramas/rel.dia

clean:
	rm -rf build
	rm -f informe.pdf

doc-preview: doc build/informe.pdf
#	./scripts/preview build/informe.pdf &
	cp build/informe.pdf . 

.PHONY: doc/diagramas/der.dia
