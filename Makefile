
all: presentacion.html documento.pdf

presentacion.html: presentacion.md
	pandoc -t dzslides -o presentacion.html presentacion.md --self-contained

documento.pdf: documento.md
	pandoc --to latex --latex-engine pdflatex -o documento.pdf documento.md --toc --toc-depth 2 -N --template template.tex