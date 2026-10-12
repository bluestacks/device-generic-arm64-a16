#
# Copyright (C) 2026 The BlueStacks Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# BS-A16-MAC: BlueStacks Mac (polar_mac / HVF) guest product, 64-bit only.
# Mirrors android_x86_64.mk; arm code runs natively so there is no native
# bridge / houdini / ndk_translation on this line.

# Use the release ART APEX for the production-compatible BlueStacks guest,
# including eng builds used by the Mac image pipeline.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# 64-only: single 64-bit zygote (init.zygote64.rc + ro.zygote=zygote64,
# matching the misc_arm64/baklava propfiles). This inheritance must come
# before the chain below that leads to core_minimal.mk.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Includes the base of the BlueStacks guest platform (BST common stack).
$(call inherit-product,device/generic/common/arm64.mk)

# BlueStacks runtime services required by the Mac Android-arm64 image.
PRODUCT_PACKAGES += \
    hwservicemanager \
    hwservicemanager_compat_symlink_module \
    vndservicemanager \
    android.hardware.power-service.example

# Linux 6.12 no longer exposes /dev/ashmem. Use the kernel's enabled ashmem
# compatibility layer for legacy BlueStacks gralloc buffers backed by memfd.
PRODUCT_SYSTEM_PROPERTIES += \
    sys.use_memfd=true

# Preserve the validated AOSP16 policy on the Mac product. Android 16
# enforces this globally; keeping it here documents the board-level source.
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Overrides
PRODUCT_NAME := android_arm64
PRODUCT_BRAND := Android
PRODUCT_DEVICE := arm64
PRODUCT_MODEL := Generic Android arm64
