LUAJIT_OS=$(shell luajit -e "print(require('ffi').os)")
LUAJIT_ARCH=$(shell luajit -e "print(require('ffi').arch)")
TARGET_DIR=$(LUAJIT_OS)-$(LUAJIT_ARCH)/

ifeq ($(LUAJIT_OS), OSX)
SASS_LIB=libsass.dylib
else
SASS_LIB=libsass.so
endif

libs: build
	cmake --build build --config Release
	mkdir -p $(TARGET_DIR)
	cp build/$(SASS_LIB) $(TARGET_DIR)

libsass/src:
	git submodule update --init libsass

build: libsass/src
	cmake -Bbuild -H. -GNinja

sass-sample/main.lua:
	git submodule update --init sass-sample

sass-sample/deps: sass-sample/main.lua
	cd sass-sample && lit install
	rm -rf sass-sample/deps/sass
	ln -s ../.. sass-sample/deps/sass

test: libs sass-sample/deps
	LUVI_APP=sass-sample lit

clean:
	rm -rf build sass-sample/deps
