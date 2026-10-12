# config.mk
#
# Product-specific compile-time definitions.
#

# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a

BOARD_USES_GENERIC_AUDIO := true

USE_OPENGL_RENDERER := true

BOARD_USE_LEGACY_UI := true

# BS-A16-MAC: BlueStacks Mac (polar_mac/HVF) guest, 64-bit only.
# Reuses the shared BST device stack from device/generic/common; the arm64
# in-tree kernel (kernel-a16 + bst-arm64_defconfig, see
# build/tasks/kernel.mk) replaces TARGET_NO_KERNEL above. mini_arm64 keeps
# the upstream AOSP config untouched.
ifeq ($(TARGET_PRODUCT),android_arm64)
TARGET_NO_KERNEL := false

# Mac-only board bits. Kept inside the product guard so mini_arm64 stays
# on the generic arm64 config.
SMALLER_FONT_FOOTPRINT := true
MINIMAL_FONT_FOOTPRINT := true
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/generic/common/bluetooth
BUILD_EMULATOR_OPENGL := true


# 64-only: no secondary arch, no native bridge (arm code runs natively;
# no libndk / libhoudini payload on this line).
TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=
TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=
TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI)
TARGET_CPU_ABI_LIST_32_BIT :=
TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI)

# camera.bst (HIDL provider wrapper) replaces the stub camera HAL.
USE_CAMERA_STUB :=

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

include device/generic/common/BoardConfig.mk

# mini_arm64 above pins BOARD_SYSTEMIMAGE_PARTITION_SIZE; the BST line uses
# the dynamic-partition-size + reserved-size mode from the common config
# (same as android_x86_64), so drop the fixed size.
BOARD_SYSTEMIMAGE_PARTITION_SIZE :=

# arm64 has no vmalloc= boot option (common adds it for non-x86_64 arches).
BOARD_KERNEL_CMDLINE := root=/dev/ram0

# android_arm64 does not inherit the goldfish generic product either; attach
# the retained BlueStacks HAL declarations and the external HIDL graphics stack.
DEVICE_MANIFEST_FILE += device/generic/arm64/manifest_bst_legacy_hal.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.allocator@2.0.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.composer@2.1.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.mapper@2.1.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    device/generic/arm64/framework_compatibility_matrix.xml
endif
