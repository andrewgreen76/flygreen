CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS = -lpthread

SRC1 = server.c
SRC2 = client.c
DEPS = 
HEADERS = 

# The target executables
TARGET1 = server
TARGET2 = client

all: $(TARGET1) $(TARGET2)

$(TARGET1): $(SRC1) $(DEPS) $(HEADERS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC1) $(DEPS) -I.

$(TARGET2): $(SRC2) $(DEPS) $(HEADERS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC2) $(DEPS) -I.

.PHONY: clean

clean:
	rm -f $(TARGET1) $(TARGET2)
