include internal.make

CLANG=$(LLVM_BIN_DIR)/clang
BUNDLER=$(LLVM_BIN_DIR)/clang-offload-bundler

default_target: all

all: all-host all-gfx900
clean: clean-host clean-gfx900

.PHONY: clean clean-gfx900 clean-host

# HOST

all-host: main

main.o: main.cpp
	$(HIPCC) -c $< -o $@

main: main.o
	$(HIPCC) $< -o $@

clean-host:
	rm main.o main

# DEVICE

all-gfx900: lib_gfx900.so

lib_gfx900.o: lib_gfx900.s
	$(CLANG) -x assembler -mcode-object-version=4 -mwavefrontsize64 -target amdgcn-amd-amdhsa -mcpu=gfx900 -c $< -o $@

lib_gfx900.so: lib_gfx900.o
	$(CLANG) -target amdgcn-amd-amdhsa $< -o $@

clean-gfx900:
	rm lib_gfx900.o lib_gfx900.so
