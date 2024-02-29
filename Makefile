################################################################################
# File: Makefile
# Description: A simple makefile for running tests using unity framework.
# Taken and modified from: [here](https://www.throwtheswitch.org/s/makefile)
# Comments and explanations added by: [me](lior.dux@develeap.com) aka zMynxx.
################################################################################
#/*******************************************************************************
# *   OS DECETIONS 
# ******************************************************************************/
ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
  endif
	TARGET_EXTENSION=exe
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	TARGET_EXTENSION=out
endif

#/*******************************************************************************
# *  ASSUME DEFAULT ACTION IS TO RUN `make test clean`
# ******************************************************************************/
.PHONY: clean
.PHONY: test

#/*******************************************************************************
# *  PATHS 
# ******************************************************************************/
PATHU = unity/src/
PATHS = src/
PATHT = test/
PATHB = build/
PATHD = build/depends/
PATHO = build/objs/
PATHR = build/results/

#/*******************************************************************************
# *  BUILD PATHS 
# ******************************************************************************/
BUILD_PATHS = $(PATHB) $(PATHD) $(PATHO) $(PATHR)

#/*******************************************************************************
# *  GROUP THE TESTS SOURCES
# ******************************************************************************/
SRCT = $(wildcard $(PATHT)*.c)

#/*******************************************************************************
# * FLAGS FOR COMPILATION 
# ******************************************************************************
# -c tells gcc to compile the file, but not to link it. This will produce a .o file.
# -MM tells gcc to output header dependencies for the compile file(s), but only those that are in single quotes (it will exclude system headers).
# 
# -MG tells gcc that it's okay if it runs into headers that it can't find. This is going to be all of the headers, honestly, because we also (purposefully) haven't told gcc anything about our include paths. We're looking for very shallow dependency tracking: just the files that are included in the test file.
# 
# -MF tells gcc we want the header dependencies to be written to a file. The next argument should be the name of the file to write to, which is why we have placed the dependency file first in our rule above.
#
# -I tells gcc where to look for include files. We're going to tell it to look in the current directory, and in the unity/src directory, and in the src directory. This is where our header files are.
#  -DTEST tells gcc to define the TEST macro. This is a macro that we're going to use to conditionally compile our code. We'll see how in a moment.
# ******************************************************************************/
COMPILE=gcc -c
LINK=gcc
DEPEND=gcc -MM -MG -MF
CFLAGS=-I. -I$(PATHU) -I$(PATHS) -DTEST

#/*******************************************************************************
# * GROUP THE RESULTS OF THE TESTS 
# ******************************************************************************/
RESULTS = $(patsubst $(PATHT)Test%.c,$(PATHR)Test%.txt,$(SRCT) )
PASSED = `grep -s PASS $(PATHR)*.txt`
FAIL = `grep -s FAIL $(PATHR)*.txt`
IGNORE = `grep -s IGNORE $(PATHR)*.txt`

#/*******************************************************************************
# * SPIT OUT THE RESULTS OF THE TESTS
# ******************************************************************************/
test: $(BUILD_PATHS) $(RESULTS)
	@echo "-----------------------\nIGNORES:\n-----------------------"
	@echo "$(IGNORE)"
	@echo "-----------------------\nFAILURES:\n-----------------------"
	@echo "$(FAIL)"
	@echo "-----------------------\nPASSED:\n-----------------------"
	@echo "$(PASSED)"
	@echo "\nDONE"

#/*******************************************************************************
# * RUN PROGRAM AND CAPTURE OUTPUTS TO TEXT FILES
# ******************************************************************************/
# SYMBOLS:
# $@ tells us where. It's makefile shorthand for "the name of this rule". 
#
# $< tells us what. It's makefile shorthand for "the first prerequisite".
#
# $^ tells us all the prerequisites.
#
# 2>&1 tells the shell to redirect stderr to stdout. This is necessary because the test program is going to print to stderr, and we want to capture that output in our results file.
#
# ******************************************************************************/
$(PATHR)%.txt: $(PATHB)%.$(TARGET_EXTENSION)
	-./$< > $@ 2>&1

# CREATE THE TEST EXECUTABLES
$(PATHB)Test%.$(TARGET_EXTENSION): $(PATHO)Test%.o $(PATHO)%.o $(PATHO)unity.o #$(PATHD)Test%.d
	$(LINK) -o $@ $^

# CREATE THE TEST OBJECT FILES
$(PATHO)%.o:: $(PATHT)%.c
	$(COMPILE) $(CFLAGS) $< -o $@

# CREATE THE SOURCE OBJECT FILES
$(PATHO)%.o:: $(PATHS)%.c
	$(COMPILE) $(CFLAGS) $< -o $@

# CREATE THE UNITY OBJECT FILES
$(PATHO)%.o:: $(PATHU)%.c $(PATHU)%.h
	$(COMPILE) $(CFLAGS) $< -o $@

# CREATE THE TEST DEPENDENCIES FILES
$(PATHD)%.d:: $(PATHT)%.c
	$(DEPEND) $@ $<

#/*******************************************************************************
# * MAKE SURE PATHS EXIST
# ******************************************************************************/
$(PATHB):
	$(MKDIR) $(PATHB)

$(PATHD):
	$(MKDIR) $(PATHD)

$(PATHO):
	$(MKDIR) $(PATHO)

$(PATHR):
	$(MKDIR) $(PATHR)

#/*******************************************************************************
# * CLEAN UP
# ******************************************************************************/
clean:
	$(CLEANUP) $(PATHO)*.o
	$(CLEANUP) $(PATHB)*.$(TARGET_EXTENSION)
	$(CLEANUP) $(PATHR)*.txt

#/*******************************************************************************
# * PRECIOUS - TELL MAKE TO KEEP THESE FILES
# ******************************************************************************/
.PRECIOUS: $(PATHB)Test%.$(TARGET_EXTENSION)
.PRECIOUS: $(PATHD)%.d
.PRECIOUS: $(PATHO)%.o
.PRECIOUS: $(PATHR)%.txt
