NAME=main
PDFLATEX_FLAGS='-shell-escape' # For minted plugin
USE_PDFLATEX=1
GV=evince
BIBTEXSRCS=references.bib

DOTS:= $(wildcard fig/*.dot)
FIGS:= $(DOTS:fig/%.dot=build/%.pdf)

OTHER+= $(FIGS)

build/%.pdf: fig/%.dot
	mkdir -p build
	@dot $< -Tpdf > $@

print-%:
	@echo '$*=$($*)'

include /usr/share/latex-mk/latex.gmk
