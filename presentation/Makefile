NAME=presentation
PDFLATEX_FLAGS='-shell-escape' # For minted plugin
USE_PDFLATEX=1
GV=evince
TEXSRCS:= codesnippets.tex

DOTS:= $(wildcard fig/*.dot)
FIGS:= $(DOTS:fig/%.dot=build/fig/%.pdf)

OTHER+= $(FIGS)

build/fig/%.pdf: fig/%.dot
	mkdir -p build/fig
	@dot $< -Tpdf > $@

include /usr/share/latex-mk/latex.gmk
