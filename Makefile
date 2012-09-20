%.pdf: %.tex
	pdflatex --shell-escape $<
