CC=gcc
CFLAGS=-framework ApplicationServices -framework Carbon -Wall -g
SERVER=159.89.136.69

all: keyrace install-bitbar

keyrace: keyrace.c
	gcc keyrace.c $(CFLAGS) -o keyrace

keyrace-server: $(wildcard *.go)
	go build -o $@ $?

test: $(wildcard *.go)
	@echo "Running the go tests..."
	go test $?
	@echo "Running the integration tests..."
	$(CURDIR)/integration-test.sh

deploy:
	scp keyrace.go root@$(SERVER):

clean:
	rm -rf keyrace keyrace.dSYM

stop:
	killall -9 keyrace

install-bitbar:
	brew cask install bitbar
	open /Applications/BitBar.app