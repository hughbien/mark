INSTALL_BIN ?= /usr/local/bin
VERSION = $(shell cat shard.yml | grep ^version | head -n1 | sed -e "s/version: //")

build: bin/mark
bin/mark:
	shards build --production
	rm -f bin/mark.dwarf

push:
	git tag v$(VERSION)
	git push --tags
	gh release create -R hughbien/mark -t v$(VERSION) v$(VERSION)

install: build
	cp bin/mark $(INSTALL_BIN)

spec: test
test:
	crystal spec $(ARGS)

clean:
	rm -rf bin

run:
	crystal run src/cli.cr -- $(ARGS)
