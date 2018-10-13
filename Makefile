all: clean test build

test: lint
	go test $(TESTFLAGS) ./...

deps:
	go get -d -v -t ./...

devel-deps: deps
	go get golang.org/x/lint/golint \
		github.com/axw/gocov/gocov \
		github.com/mattn/goveralls

LINT_RET = .golint.txt
lint: devel-deps
	go vet ./...
	rm -f $(LINT_RET)
	golint ./... | tee -a $(LINT_RET)
	test ! -s $(LINT_RET)

cover: devel-deps
	tool/cover.sh

clean:
	go clean

.PHONY: test deps devel-deps clean lint cover
