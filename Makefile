INSTALL_BIN ?= /usr/local/bin

spec: test
test:
	crystal spec $(ARGS)

build: bin/mark
bin/mark:
	shards build --production
	rm bin/mark.dwarf

install: build
	cp bin/mark $(INSTALL_BIN)

clean:
	rm -rf bin

run:
	crystal run src/cli.cr -- $(ARGS)
