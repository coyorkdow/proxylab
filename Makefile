# Makefile for Proxy Lab 
#
# You may modify this file any way you like (except for the handin
# rule). You instructor will type "make" on your specific Makefile to
# build your proxy from sources.

CC = gcc
CFLAGS = -g -Wall
LDFLAGS = -lpthread

CFLAGS += -ITinyCLog/
LOG_FLAGS = -DTINY_C_LOG_POSIX_IMPL -DUSER_LOG_LEVEL=DEBUG -DUSER_LOGFILE_DIR=\"proxy.log\"

all: proxy

csapp.o: csapp.c csapp.h
	$(CC) $(CFLAGS) -c csapp.c

proxy.o: proxy.c
	$(CC) $(CFLAGS) $(LOG_FLAGS) -c proxy.c

cache.o: cache.c cache.h
	$(CC) $(CFLAGS) -c cache.c

proxy: proxy.o csapp.o cache.o
	$(CC) $(CFLAGS) proxy.o csapp.o cache.o -o proxy $(LDFLAGS)

# Creates a tarball in ../proxylab-handin.tar that you can then
# hand in. DO NOT MODIFY THIS!
handin:
	(make clean; cd ..; tar cvf $(USER)-proxylab-handin.tar proxylab-handout --exclude tiny --exclude nop-server.py --exclude proxy --exclude driver.sh --exclude port-for-user.pl --exclude free-port.sh --exclude ".*")

clean:
	rm -f *~ *.o proxy core *.tar *.zip *.gzip *.bzip *.gz

