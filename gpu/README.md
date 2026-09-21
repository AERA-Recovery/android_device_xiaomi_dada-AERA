# Xiaomi SM8750 recovery graphics stack

The proprietary ARM64 Adreno userspace libraries and Gen8 firmware in this
tree come from the owner's extracted Xiaomi 15 (`dada`) OTA. They are not
copied from Dodge or another SM8750 device: the Xiaomi and OnePlus blobs have
different hashes and must remain matched to their respective stock stacks.

`AERA_LOAD_VENDOR_MODULES` loads Xiaomi's stock `msm_kgsl.ko` and its declared
dependencies from the installed `vendor_dlkm` partition. The ramdisk contains
the matching EGL/GLES2, allocator/mapper closure and Gen8 firmware needed by
AERA's LVGL OpenGL renderer. The software renderer remains available if the
native stack cannot initialize.
