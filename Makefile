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

build:
	cmake -G Ninja -S . -B $(BUILD_DIR) && \
	cd $(BUILD_DIR) && \
	ninja -j$(NUM_JOB)
.PHONY: build

clean:
	rm -rf $(BUILD_DIR)
.PHONY: clean

format:
	./format.sh run
.PHONY: format

check_format:
	./format.sh check
.PHONY: check_format
