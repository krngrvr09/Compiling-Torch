# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

# Detect C and C++ compiler options
# if not gcc and g++, default to clang-7
C_COMPILER=$(notdir $(CC))

ifeq ($(C_COMPILER), gcc)
        CXX_COMPILER=$(notdir $(CXX))
        USE_GCC = true
endif

ifeq ($(USE_GCC),)
        CC = clang-7
        CXX = clang++-7
        C_COMPILER=clang
        CXX_COMPILER=clang++
endif


CFLAGS=$(shell pkg-config oeenclave-$(C_COMPILER) --cflags)
CXXFLAGS=$(shell pkg-config oeenclave-$(CXX_COMPILER) --cflags)
LDFLAGS=$(shell pkg-config oeenclave-$(CXX_COMPILER) --libs)


THNN_Dir := /home/karan/temp/THNN
TH_Dir := /home/karan/temp/TH


Torch_C_Files := $(wildcard $(THNN_Dir)/*.c) $(wildcard $(TH_Dir)/*.c)
Torch_C_Objects := $(Torch_C_Files:.cpp=.o)

Enclave_Include_Paths := -I$(TH_Dir) -I$(THNN_Dir)

all:
	$(MAKE) build

build: $(Torch_C_Object)
	@echo "-2-2-2-2-2"
	@echo "$(Torch_C_Files)"
	@echo "-1-1-1-1-1-1"
	@echo "$(Torch_C_objects)"
	@echo "ahahahha"
	@echo "$(C_COMPILER)"
	@echo "11111"
	@echo "$(CFLAGS)"
	@echo "22222"
	@echo "$(CXXFLAGS)"
	@echo "33333"
	@echo "$(LDFLAGS)"
	@echo "44444"
	gcc -c $(Enclave_Include_Paths) $(Torch_C_Files)
	#@echo "55555"
	#gcc $(Enclave_Include_Paths) -fPIC -o file-encryptorenc.so $(Torch_C_Objects) $(LDFLAGS)
	#$(LDFLAGS) $(Torch_C_Objects) $(LDFLAGS)


$(TH_Dir)/%.o: $(TH_Dir)/%.c
	@echo "66666"
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "CC  <=  $<"

$(THNN_Dir)/%.o: $(THNN_Dir)/%.c
	@echo "77777"
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "CC  <=  $<"

clean:
	rm -rf ./TH/*.o ./THNN/*.o ./*.o
