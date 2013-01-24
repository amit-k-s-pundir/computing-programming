mod_testFilter.la: mod_testFilter.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_testFilter.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_testFilter.la
