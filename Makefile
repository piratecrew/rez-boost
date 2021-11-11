
SHELL := /bin/bash

# Rez variables, setting these to sensible values if we are not building from rez
REZ_BUILD_PROJECT_VERSION ?= NOT_SET
REZ_BUILD_INSTALL_PATH ?= /usr/local
REZ_BUILD_SOURCE_PATH ?= $(shell dirname $(lastword $(abspath $(MAKEFILE_LIST))))
BUILD_ROOT := $(REZ_BUILD_SOURCE_PATH)/build
REZ_BUILD_PATH ?= $(BUILD_ROOT)
REZ_JPEGTURBO_ROOT ?= /usr/local
REZ_PYTHON_VERSION ?= 3

# Source
VERSION ?= $(REZ_BUILD_PROJECT_VERSION)
_VERSION := $(shell echo $(VERSION) | tr '.' '_')
ARCHIVE_URL := https://downloads.sourceforge.net/project/boost/boost/$(VERSION)/boost_$(_VERSION).tar.gz
LOCAL_ARCHIVE := $(BUILD_ROOT)/boost.$(VERSION).tar.gz

# Build time locations
BUILD_TYPE = Release
BUILD_DIR = ${REZ_BUILD_PATH}/BUILD/$(BUILD_TYPE)
SOURCE_DIR := $(BUILD_DIR)/boost_$(_VERSION)/

# Installation prefix
PREFIX ?= ${REZ_BUILD_INSTALL_PATH}

# Python version to find for bindings
PYTHON ?= $(shell which python)
PYTHON_MAJOR_VERSION := $(shell python -c "import sys;sys.stdout.write(str(sys.version_info[0]))")
PYTHON_ROOT ?= $(shell dirname $(dirname $(PYTHON)))
PYTHON_INCLUDE := $(shell python$(PYTHON_MAJOR_VERSION)-config --includes | cut -d ' ' -f 1 | cut -c 3-)
export CPLUS_INCLUDE_PATH = $(PYTHON_INCLUDE)

.PHONY: build install test clean
.DEFAULT_GOAL := build

clean:
	rm -rf $(BUILD_ROOT)

$(BUILD_DIR): # Prepare build directories
	mkdir -p $(BUILD_ROOT)
	mkdir -p $(BUILD_DIR)

$(LOCAL_ARCHIVE): | $(BUILD_DIR)
	cd $(BUILD_ROOT) && wget -O $(LOCAL_ARCHIVE) $(ARCHIVE_URL)

$(SOURCE_DIR): $(LOCAL_ARCHIVE)
	cd $(BUILD_DIR) && tar -xvzf $<

build: $(SOURCE_DIR) # configure and build
ifeq "$(VERSION)" "NOT_SET"
	$(warn "No version was specified, provide one with: VERSION=0.20.2")
else
	cd $(SOURCE_DIR) \
	&& ./bootstrap.sh --with-python=$(PYTHON) 
endif

install: build
	cd $(SOURCE_DIR) && ./b2 install -d1 -j8 --prefix=$(PREFIX) --exec-prefix=$(PREFIX) link=static,shared --toolset=gcc cxxflags=-fPIC

test: build # Run the tests in the build
	$(MAKE) -C $(BUILD_DIR) test
