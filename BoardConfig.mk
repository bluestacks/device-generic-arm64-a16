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
# BlueStacks mac (qvirt) guest is arm64-only; the A13 device/bst/qvirt
# board kept TARGET_2ND_ARCH disabled the same way.

BOARD_USES_GENERIC_AUDIO := true

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

TARGET_USERIMAGES_USE_EXT4 := true
# System image size is content + BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE from the common board (config.mk rejects SIZE + RESERVED together).
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# BlueStacks shared board base (sepolicy dirs, emulator off, BT cfg),
# same include the android_x86_64 product uses.
include device/generic/common/BoardConfig.mk

# Legacy HIDL surface retained from A13, same declarations as android_x86_64.
DEVICE_MANIFEST_FILE += device/generic/arm64/manifest_bst_legacy_hal.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.allocator@2.0.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.composer@2.1.xml
DEVICE_MANIFEST_FILE += device/generic/common/manifest/android.hardware.graphics.mapper@2.1.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    device/generic/arm64/framework_compatibility_matrix.xml

BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true
