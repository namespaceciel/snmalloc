PROJECT_SOURCE_DIR := $(abspath ./)
BUILD_DIR ?= $(PROJECT_SOURCE_DIR)/build
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
    NUM_JOB := $(shell nproc)
else ifeq ($(UNAME_S), Darwin)
    NUM_JOB := $(shell sysctl -n hw.ncpu)
else
    NUM_JOB := 1
endif

clean:
	rm -rf $(BUILD_DIR)
.PHONY: clean

build:
	cmake -S . -B $(BUILD_DIR) && \
	cmake --build $(BUILD_DIR) -j $(NUM_JOB)
.PHONY: build

format:
	./format.sh run $(PROJECT_SOURCE_DIR)
.PHONY: format

check_format:
	./format.sh check $(PROJECT_SOURCE_DIR)
.PHONY: check_format
