
all:
	pandoc -t dzslides -o presentacion.html presentacion.md --self-contained
	pandoc --to latex --latex-engine pdflatex -o documento.pdf documento.md --toc -N --template template.tex