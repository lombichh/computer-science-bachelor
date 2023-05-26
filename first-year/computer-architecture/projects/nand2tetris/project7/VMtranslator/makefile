SOURCES = main.c parser.c code_writer.c string.c cache.c
EXECUTABLE = VMtranslator

all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
	gcc -o $(EXECUTABLE) $(SOURCES)

clean:
	rm -f $(EXECUTABLE) *.asm