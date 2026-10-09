# BlueStacks mac (qvirt) arm64 product for Android 16.
# Ported from android-mac device/bst/qvirt bst_arm64.mk onto the generic
# arm64 base, mirroring how android_x86_64 carries the Windows guest.

PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true
$(call inherit-product,$(LOCAL_PATH)/../common/device.mk)
$(call inherit-product,$(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product,$(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product-if-exists,frameworks/base/data/sounds/AudioPackage6.mk)

PRODUCT_PACKAGES += \
    hwservicemanager \
    hwservicemanager_compat_symlink_module \
    vndservicemanager \
    android.hardware.power-service.example

PRODUCT_SYSTEM_PROPERTIES += \
    sys.use_memfd=true

PRODUCT_ENFORCE_VINTF_MANIFEST := true

PRODUCT_NAME := android_arm64
PRODUCT_BRAND := Android-arm64
PRODUCT_DEVICE := arm64
PRODUCT_MODEL := BlueStacks qvirt arm64 (mac)
