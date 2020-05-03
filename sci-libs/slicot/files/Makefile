#!/usr/bin/make -f
# -*- makefile -*-

.PHONY: default
default: libslicot.so

SLICOT_SRC=$(sort $(shell echo src/*.f))
SLICOT_OBJ=$(SLICOT_SRC:.f=.o)

shared_dir:
	mkdir -p $(subst _dir,,$(@))
	touch $@

$(subst src/,shared/,$(SLICOT_OBJ)): \
  shared/%.o : src/%.f shared_dir

	$(F77) $(FFLAGS) -fPIC -c $< -o $@

libslicot.so: libslicot.so.$(SO)
	ln -snf $< $@

libslicot.so.$(SO): libslicot.so.$(VERS)
	ln -snf $< $@

libslicot.so.$(VERS): $(subst src/,shared/,$(SLICOT_OBJ))
	$(F77) -fPIC ${FFLAGS} $(LDFLAGS) -shared -Wl,-soname=libslicot.so.$(SO) -o $@ $^
