INSTALL_BIN ?= /usr/local/bin

spec: test
test:
	crystal spec $(ARGS)

build: target/mark
target/mark:
	crystal build src/cli.cr --release
	mkdir -p target
	mv cli target/mark
	rm cli.dwarf

install: build
	cp target/mark $(INSTALL_BIN)

clean:
	rm -rf cli cli.dwarf target

run:
	crystal run src/cli.cr -- $(ARGS)
