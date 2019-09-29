
NOTES_ROOT = my_notes
NOTES_SRC = $(NOTES_ROOT).tex
NOTES_PDF = $(NOTES_ROOT).pdf

##
## Tools
##
LATEX = pdflatex
DVIPDF = dvipdf 
RM = /bin/rm
MV = /bin/mv
MKDIR = /bin/mkdir

##
## Directories
##
SRC_DIR = latex
OUTPUT_DIR = outputs
NOTES_OUTPUT_DIR = Notes

MAKE_DIRS = $(OUTPUT_DIR) $(NOTES_OUTPUT_DIR)


LATEX_OPTIONS = -shell-escape

BUILD_LIST = dirs notes

all: $(BUILD_LIST)

dirs:
	$(MKDIR) -p $(MAKE_DIRS)

notes: 
	$(LATEX) $(LATEX_OPTIONS) -output-directory=$(OUTPUT_DIR) $(SRC_DIR)/$(NOTES_SRC)	
	$(LATEX) $(LATEX_OPTIONS) -output-directory=$(OUTPUT_DIR) $(SRC_DIR)/$(NOTES_SRC)
	$(MV) $(OUTPUT_DIR)/$(NOTES_PDF) $(NOTES_OUTPUT_DIR)	

clean:
	$(RM) -rf $(OUTPUT_DIR)
	find . -name "*~" | xargs $(RM) -f
	$(RM) -rf $(NOTES_OUTPUT_DIR) _minted-my_notes/

