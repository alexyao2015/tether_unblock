getprop = $(shell cat module/module.prop | grep "^$(1)=" | head -n1 | cut -d'=' -f2)

MODNAME ?= $(call getprop,id)
MODVER ?= $(call getprop,version)
ZIP = $(MODNAME)-$(MODVER).zip
ZIP_LATEST = $(MODNAME)-latest.zip

all: $(ZIP)

zip: $(ZIP)

%.zip: clean
	cd module && zip -r9 ../$(ZIP) .
	cp $(ZIP) $(ZIP_LATEST)

install: $(ZIP)
	adb push $(ZIP) /sdcard/
	echo '/sbin/.magisk/busybox/unzip -p "/sdcard/$(ZIP)" META-INF/com/google/android/update-binary | /sbin/.magisk/busybox/sh /proc/self/fd/0 x x "/sdcard/$(ZIP)"' | adb shell su -c sh -
	adb shell rm -f "/sdcard/$(ZIP)"

clean:
	rm -f *.zip

update:
	curl https://raw.githubusercontent.com/topjohnwu/Magisk/master/scripts/module_installer.sh > module/META-INF/com/google/android/update-binary

.PHONY: all zip %.zip install clean update
