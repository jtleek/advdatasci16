all: 
	R -e 'library(rmarkdown); render("index.Rmd");'
	open index.html
clean:
	rm index.html; 	
open:
	open index.html
edit:
	open ${fname}.Rmd