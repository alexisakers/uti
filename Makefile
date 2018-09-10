test:
	swift test

build:
	swift build -c release --static-swift-stdlib

install:
	rm -f /usr/local/bin/uti
	cp ./.build/release/uti /usr/local/bin/uti
