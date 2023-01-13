main.pdf: ./main.tex ./chapters/* ref.bib
	docker run --rm -it --user="$$(id -u):$$(id -g)" --net=none -v "$$(pwd):/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/$<

clean:
	@rm *.{nav,snm,toc,aux,log,fls,out,fdb_latexmk} ./chapters/*.aux
