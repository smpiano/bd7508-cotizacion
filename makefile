doc: build/informe.pdf

build:
	-mkdir -p build
	-mkdir -p build/images

build/informe.pdf: build build/images/der.jpeg build/images/rel.jpg doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex
	pdflatex --output-directory build doc/informe.tex

#build/images/der.jpeg: build docs/diagramas/der.dia
build/images/der.jpeg: doc/diagramas/der.dia
	dia --export=build/images/der.jpeg --filter=jpeg doc/diagramas/der.dia

build/images/rel.jpg: #build docs/diagramas/rel.dia
	#dia --export=build/images/rel.jpg --filter=jpg doc/diagramas/rel.dia
	cp doc/diagramas/rel.jpg build/images/

clean:
	rm -rf build
	rm -f informe.pdf

doc-preview: doc build/informe.pdf
#	./scripts/preview build/informe.pdf &
	cp build/informe.pdf . 

.PHONY: doc/diagramas/der.dia
