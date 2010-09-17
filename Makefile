TWEAK_NAME = iLockFix
iLockFix_OBJC_FILES = iLockFix.m
iLockFix_FRAMEWORKS = Foundation UIKit

ADDITIONAL_CFLAGS = -std=c99

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk
