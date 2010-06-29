# set latex compiler (LTX) if unset by the user
LTX ?= latex

outputdir := output

#  source files (list them here in case we ever need them listed)

SRCS := main.tex \
	abstract.tex \
	approach.tex \
	implementation.tex \
	conclusions.tex \
	introduction.tex \
	related.tex \
	results.tex

#  targets

# the default target is a PDF file
.PHONY : pdf
pdf: $(outputdir)/draft.pdf

${outputdir}/draft.pdf : *.tex *.bib
	@mkdir -p $(outputdir)
	@$(LTX) main.tex 
# will put in calls to bibtex when we have some references
	bibtex main.aux 
	@$(LTX) main.tex 
	@$(LTX) main.tex 
	@$(LTX) main.tex 
	dvipdf main.dvi
	mv main.pdf $(outputdir)/draft.pdf
# clean up some of the crap generated
	rm *.log
	rm *.dvi
	rm *.aux
	rm -f *~
# make sure we end with a newline
	@echo ""

.PHONY : bibtex
bibtex :
	bibtex main.aux
 
.PHONY : clean
clean :
	rm -rf $(outputdir)
