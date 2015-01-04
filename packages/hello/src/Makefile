CC=gcc
WFLAGS=-Wall
CFLAGS=-O2
INCLUDES=-Iinclude

APPNAME=hello_app
LIBNAME=libhello.so

all: $(LIBNAME) $(APPNAME) mmap-rw mmap-rwx aslr-test-withpie aslr-test-without

#	$(OBJDUMP) -a -f -h $(APPNAME)
#	$(OBJDUMP) -a -f -h $(LIBNAME)
# -Wl,-z,relro -Wl,-z,now

%.o: %.c
	$(CC) $(WFLAGS) -c -o $@ $(INCLUDES) $(CFLAGS) $<

LIB_OBJ=hello_lib.o

APP_OBJ=hello.o

$(LIBNAME): $(LIB_OBJ)
	$(CC) -shared -o $@ $^

$(APPNAME): $(APP_OBJ)
	$(CC) -lhello -L. -o $@ $^

mmap-rwx: mmap-rwx.c
	$(CC) -DBAD -o mmap-rwx mmap-rwx.c

mmap-rw: mmap-rwx.c
	$(CC) -UBAD -o mmap-rw mmap-rwx.c

aslr-test-withpie: aslr-test.c
	$(CC) -o aslr-test-withpie -fPIC -pie aslr-test.c

# -nopie: unrecognized option
aslr-test-without:
	$(CC) -o aslr-test-without -fno-PIC aslr-test.c
