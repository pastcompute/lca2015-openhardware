CC=gcc
WFLAGS=-Wall
CFLAGS=-O2
INCLUDES=-Iinclude

APPNAME=hello_app
LIBNAME=libhello.so

all: $(LIBNAME) $(APPNAME)

#	$(OBJDUMP) -a -f -h $(APPNAME)
#	$(OBJDUMP) -a -f -h $(LIBNAME)

%.o: %.c
	$(CC) $(WFLAGS) -c -o $@ $(INCLUDES) $(CFLAGS) $<

LIB_OBJ=hello_lib.o

APP_OBJ=hello.o

$(LIBNAME): $(LIB_OBJ)
	$(CC) -shared -o $@ $^

$(APPNAME): $(APP_OBJ)
	$(CC) -lhello -L. -o $@ $^
