ifneq ($(CHECKRA1N_MEMO),1)
$(error Use the main Makefile)
endif

ifneq ($(wildcard $(BUILD_WORK)/readline/.build_complete),)
readline:
	@echo "Using previously built readline."
else
readline: setup
	cd $(BUILD_WORK)/readline && ./configure -C \
		--host=$(GNU_HOST_TRIPLE) \
		--prefix=/usr \
		ac_cv_type_sig_atomic_t=no
	$(MAKE) -C $(BUILD_WORK)/readline
	$(FAKEROOT) $(MAKE) -C $(BUILD_WORK)/readline install \
		DESTDIR=$(BUILD_STAGE)/readline
	$(MAKE) -C $(BUILD_WORK)/readline install \
		DESTDIR=$(BUILD_BASE)
	touch $(BUILD_WORK)/readline/.build_complete
endif

.PHONY: readline