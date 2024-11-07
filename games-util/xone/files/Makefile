KERNEL_DIR ?= /usr/src/linux
PWD := $(shell pwd)

all: module

module:
	@$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules
