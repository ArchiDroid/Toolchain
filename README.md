ArchiToolchain
===================================================
This toolchain is optimized for:
- Cortex A7 CPU (-mcpu=cortex-a7)
- NEON VFPv4 FPU (-mfpu=neon-vfpv4)
- Hard-float ABI (-mfloat-abi=hard)
- Linux Kernel 3.4.X

This toolchain uses:
- GNU GCC 5.1.X (latest)
- Other components specified in ".config" file

---------------------------------------------------
ArchiToolchain is a minimalistic toolchain which should be used as "arm-eabi" alternative during compiling Linux kernels. It uses, and is possible, thanks to [crosstool-NG](https://github.com/crosstool-ng/crosstool-ng)

Exact config used for building each toolchain is always available in ".config" file, which can be then used for reproducing the build with latest crostool-NG.

Each ArchiToolchain is pre-optimized for specific target, which means that some options are always used as the default ones. You can still override them by specifying your own flags during compilation.

Check [currently available toolchains](https://github.com/ArchiDroid/Toolchain/branches/all?query=archi) for the one that suits you best. In case you can't find such, you can always use [generic ArchiToolchain](https://github.com/ArchiDroid/Toolchain/tree/architoolchain-5.1-arm-linux-gnueabihf), which should work with all targets, but is not pre-optimized for any of them.


---------------------------------------------------
# AOSP trees

You can use ArchiToolchain also in AOSP trees (during compiling of an Android) by adding it in your local manifest. Local manifest for AOSP is located in ```$(SRCTREE)/.repo/local_manifests/roomservice.xml```, where ```$(SRCTREE)``` is the root of your AOSP tree. Local manifest may not exist (yet), so you may need to create it firstly.

Example for using this ArchiToolchain with Lollipop AOSP tree:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
<!-- cut here -->
<remove-project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8" />
<project name="ArchiDroid/Toolchain" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.8" remote="github" revision="architoolchain-5.1-arm-linux-gnueabihf-cortex_a7_neon_vfpv4" />
<!-- cut here -->
</manifest>
```

Example for using this ArchiToolchain with KitKat AOSP tree:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
<!-- cut here -->
<remove-project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" />
<project name="ArchiDroid/Toolchain" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" remote="github" revision="architoolchain-5.1-arm-linux-gnueabihf-cortex_a7_neon_vfpv4" />
<!-- cut here -->
</manifest>
```

After next ```repo sync```, you should notice that ArchiToolchain repo is available in the ```path``` specified by your manifest.
