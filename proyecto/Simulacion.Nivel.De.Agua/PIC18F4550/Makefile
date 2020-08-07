###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = PIC18F4550
COMPILER = "CCS for PIC"
TARGET = Debug
SHELL = C:\Windows\system32\cmd.exe

## Tools general options
CCFLAGS=-J +DF +ES -P -Z +O8 +CC +EXPORT +FH
LDFLAGS=-J +DF +ES -P -Z +O8 +CC +FH

## Processing Tools
CC=ccsc.exe
LD=ccsc.exe
#  C:/Users/ELIAS/Documents/PIC18F4550/Debug.cof: TOOL=LD
#     C:/Users/ELIAS/Documents/PIC18F4550/./main.o: TOOL=CC
#        C:/Users/ELIAS/Documents/PIC18F4550/main.c

# Build tree:
all:	Debug

Debug:	Debug.cof

Debug.cof:	main.o 
	$(LD) $(LDFLAGS)  LINK="Debug.cof=main.o"

main.o:	main.c 
	$(CC) $(CCFLAGS)  "main.c"

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf ./Debug.esym
	rm -rf ./Debug.sym
	rm -rf ./Debug.lst
	rm -rf Debug.err
	rm -rf ./main.esym
	rm -rf ./main.osym
	rm -rf ./main.err

# cleanup - delete all generated files
clean:	tidy
	rm -rf Debug.cof
	rm -rf main.o

