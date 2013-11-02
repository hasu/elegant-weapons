SCM_FILES := $(wildcard lib/elegant-weapons/*.scm)
RKT_FILES := $(patsubst %.scm, %.rkt, $(SCM_FILES))

setup-for-racket : $(RKT_FILES)

%.rkt : %.scm
	if ([ ! -L $@ ] && [ ! -e $@ ]); then ln -s `basename $<` $@; fi
