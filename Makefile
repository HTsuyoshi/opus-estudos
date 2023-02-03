DIRECTORIES='docker' 'kubernetes' 'aws' 'terraform'
LATEX_FILES='beamercolorthemeDarkConsole.sty' 'beamerthemeDarkConsole.sty' 'kmbeamer_color.sty' 'kmbeamer_common.sty' 'svgcolor.sty'

main.pdf: ./main.tex ./chapters/*
	docker run --rm -it --user="$$(id -u):$$(id -g)" --net=none -v "$$(pwd):/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/$<

.PHONY: 'clean'
clean:
	@rm *.{nav,snm,toc,aux,log,fls,out,fdb_latexmk,bbl,bcf,blg,run.xml} ./chapters/*.aux

.PHONY: 'setup'
setup:
	@for dir in $(DIRECTORIES); do \
		for f in $(LATEX_FILES); do \
			cp $$(pwd)/latex_theme/$$f ./$$dir/presentation/$$f 2>&- || \
				echo "Error while creating ./$$dir/presentation/$$f"; \
		done; \
		ln -s $$(pwd)/Makefile ./$$dir/presentation/Makefile 2>&- || \
		echo "Error while creating ./$$dir/presentation/Makefile"; \
	done

