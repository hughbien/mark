spec: test

test:
	crystal spec $(ARGS)

build:
	crystal build src/cli.cr --release
	mkdir -p target
	mv cli target/mark
	rm cli.dwarf

clean:
	rm -rf cli cli.dwarf target

run:
	crystal run src/cli.cr -- $(ARGS)
