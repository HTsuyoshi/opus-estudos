main.pdf: ./main.tex ./chapters/* ref.bib
	docker run --rm -it --user="$$(id -u):$$(id -g)" --net=none -v "$$(pwd):/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/$<

.PHONY: 'clean'
clean:
	@rm *.{nav,snm,toc,aux,log,fls,out,fdb_latexmk,bbl,bcf,blg,run.xml} ./chapters/*.aux

.PHONY: 'setup'
setup:
	@ln -s $$(pwd)/Makefile ./docker/presentation/Makefile 2>&- || \
		echo 'Error while creating docker/presentation/Makefile'
	@ln -s $$(pwd)/Makefile ./kubernetes/presentation/Makefile 2>&- || \
		echo 'Error while creating kubernetes/presentation/Makefile'
	@ln -s $$(pwd)/Makefile ./aws/presentation/Makefile 2>&- || \
		echo 'Error while creating aws/presentation/Makefile'
	@ln -s $$(pwd)/Makefile ./terraform/presentation/Makefile 2>&- || \
		echo 'Error while creating terraform/presentation/Makefile'
