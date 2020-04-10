INSTALL_BIN ?= /usr/local/bin
VERSION = $(shell cat shard.yml | grep version | sed -e "s/version: //")

spec: test
test:
	crystal spec $(ARGS)

build: bin/mark
bin/mark:
	shards build --production
	rm bin/mark.dwarf

install: build
	cp bin/mark $(INSTALL_BIN)

release: build
	mv bin/mark bin/mark-darwin64-$(VERSION)
	docker run --rm -it -v $(PWD):/workspace -w /workspace crystallang/crystal:latest-alpine shards build --production --static
	mv bin/mark bin/mark-linux64-$(VERSION)

clean:
	rm -rf bin

run:
	crystal run src/cli.cr -- $(ARGS)
