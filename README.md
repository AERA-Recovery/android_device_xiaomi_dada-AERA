# AERA device tree for Xiaomi 15 (dada)

AERA Recovery Project device support for Xiaomi 15 (`dada`).

Xiaomi 15 Pro and Ultra are not supported by this build target.

The tree includes the adaptive AERA UI, fastbootd, decryption support, Wi-Fi,
GPU acceleration, recovery audio, haptics and the usual recovery operations.

## Build

After syncing the private AERA 16.0 manifest:

```bash
export AERA_BUILD_DEVICE=dada
source build/envsetup.sh
lunch twrp_dada-bp2a-eng
mka recoveryimage
```

## Credits

This repository retains the complete history of
[YuKongA's original TWRP tree](https://github.com/YuKongA/twrp_device_xiaomi_sm8750_thales).
