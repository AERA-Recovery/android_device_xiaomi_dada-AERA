# AERA device tree for Xiaomi SM8750

AERA Recovery Project device support for the Xiaomi 15 family:

- Xiaomi 15 (`dada`)
- Xiaomi 15 Pro (`haotian`)
- Xiaomi 15 Ultra (`xuanyuan`)

The tree includes the adaptive AERA UI, fastbootd, decryption support, Wi-Fi,
GPU acceleration, recovery audio, haptics and the usual recovery operations.

## Build

After syncing the private AERA 16.0 manifest:

```bash
source build/envsetup.sh
lunch twrp_sm8750_thales-bp2a-eng
mka recoveryimage
```

## Credits

This repository retains the complete history of
[YuKongA's original TWRP tree](https://github.com/YuKongA/twrp_device_xiaomi_sm8750_thales).
