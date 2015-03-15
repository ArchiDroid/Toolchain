ArchiToolchain
===================================================
This toolchain is optimized for:
- ARMv7-a architecture (-march=armv7-a)
- Cortex A9 CPU (-mcpu=cortex-a9 -mtune=cortex-a9)
- NEON FPU (-mfpu=neon)
- Hard-float ABI (-mfloat-abi=hard)
- Linux Kernel 3.0.X

This toolchain uses:
- Linaro GCC 4.9.X (latest)
- Other components specified in ".config" file

---------------------------------------------------
ArchiToolchain is a minimalistic toolchain which should be used as "arm-eabi" alternative during compiling Linux kernels. It uses, and is possible, thanks to [crosstool-NG](https://github.com/crosstool-ng/crosstool-ng)

Exact config used for building each toolchain is always available in ".config" file, which can be then used for reproducing the build with latest crostool-NG.

Each ArchiToolchain is pre-optimized for specific target, which means that some options are always used as the default ones. You can still override them by specifying your own flags during compilation.

Check [currently available toolchains](https://github.com/ArchiDroid/Toolchain/branches/all?query=archi) for the one that suits you best. In case you can't find such, you can always use [generic ArchiToolchain](https://github.com/ArchiDroid/Toolchain/tree/architoolchain-4.9-arm-linux-gnueabihf-generic), which should work with all targets, but is not pre-optimized for any of them.


---------------------------------------------------
# AOSP trees

You can use ArchiToolchain also in AOSP trees (during compiling of an Android) by adding it in your local manifest. Local manifest for AOSP is located in ```$(SRCTREE)/.repo/local_manifests/roomservice.xml```, where ```$(SRCTREE)``` is the root of your AOSP tree. Local manifest may not exist (yet), so you may need to create it firstly.

Example for using ArchiToolchain with Lollipop AOSP tree:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
<!-- cut here -->
<remove-project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8" />
<project name="ArchiDroid/Toolchain" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.8" remote="github" revision="architoolchain-4.9-arm-linux-gnueabihf-generic" />
<!-- cut here -->
</manifest>
```

Example for using ArchiToolchain with KitKat AOSP tree:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
<!-- cut here -->
<remove-project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" />
<project name="ArchiDroid/Toolchain" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" remote="github" revision="architoolchain-4.9-arm-linux-gnueabihf-generic" />
<!-- cut here -->
</manifest>
```

Of course you should change ```revision="architoolchain-4.9-arm-linux-gnueabihf-generic"``` to the one that suits you best.

After next ```repo sync```, you should notice that ArchiToolchain repo is available in the ```path``` specified by your manifest.
