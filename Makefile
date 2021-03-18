INSTALL_BIN ?= /usr/local/bin
VERSION = $(shell cat shard.yml | grep ^version | head -n1 | sed -e "s/version: //")

build: bin/mark
bin/mark:
	shards build --production
	rm bin/mark.dwarf

build-static: build
	docker run --rm -it -v $(PWD):/workspace -w /workspace crystallang/crystal:0.36.1-alpine shards build --production --static
	mv bin/mark bin/mark-linux64

install: build
	cp bin/mark $(INSTALL_BIN)

spec: test
test:
	crystal spec $(ARGS)

clean:
	rm -rf bin

run:
	crystal run src/cli.cr -- $(ARGS)
