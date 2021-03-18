# Building Boot Firmware for CompuLab's i.MX8 QuadMax products

Supported machines:

* `cl-som-imx8max`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|cl-som-imx8max|export MACHINE=cl-som-imx8max

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=rel_imx_5.4.70_2.3.0|
|NXP IMX SECO firmware name|export IMX_SECO=imx-seco-3.7.4|
|CompuLab branch name|export CPL_BRANCH=master|


## Prerequisites
It is up to developer to setup arm64 build environment:<br>
* Download and install toolchain as described [here](toolchain.md)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir ${MACHINE}
cd ${MACHINE}
export SRC_ROOT=$(pwd)
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8qm.git
export PATCHES=$(pwd)/meta-bsp-imx8qm/recipes-bsp/u-boot/compulab/imx8qm
export LAYER_DIR=$(pwd)/meta-bsp-imx8qm
</pre>

## Mkimage setup
* Download the mkimage:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-mkimage.git
git -C imx-mkimage checkout ${NXP_RELEASE} -b mkimage-${MACHINE}
</pre>

## Arm Trusted Firmware (ATF) setup
* Download the ATF:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-atf.git
git -C imx-atf checkout ${NXP_RELEASE} -b atf-${MACHINE}
</pre>
* Make bl31.bin
<pre>
make -C imx-atf PLAT=imx8qm bl31
cp -v imx-atf/build/imx8qm/release/bl31.bin ${SRC_ROOT}/imx-mkimage/iMX8QM/
</pre>

## IMX SECO Firmware setup
* Download the imx-seco file:
<pre>
wget http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/${IMX_SECO}.bin
bash ${IMX_SECO}.bin --auto-accept
cp -v ${IMX_SECO}/firmware/seco/mx8qmb0-ahab-container.img ${SRC_ROOT}/imx-mkimage/iMX8QM/
</pre>

## System Controller Firmware (SCFW) setup
<pre>
cp -v ${LAYER_DIR}/recipes-bsp/imx-sc-firmware/firmware/cl-som-imx8max-scfw-tcm.bin ${SRC_ROOT}/imx-mkimage/iMX8QM/scfw_tcm.bin
</pre>
## U-Boot
* Download the U-Boot source and apply CompuLab BSP patches:
<pre>
git clone https://source.codeaurora.org/external/imx/uboot-imx.git
git -C uboot-imx checkout ${NXP_RELEASE} -b u-boot-${MACHINE}
git -C uboot-imx am ${PATCHES}/*.patch
</pre>

* Compile U-Boot:
<pre>
make -C uboot-imx cl_som_imx8max_defconfig
make -C uboot-imx
</pre>

* Copy files to the mkimage directory:
<pre>
cp -v uboot-imx/u-boot.bin ${SRC_ROOT}/imx-mkimage/iMX8QM/
</pre>


## Compiling the **flash.bin** imx-boot image:
* Issue:
<pre>
cd ${SRC_ROOT}/imx-mkimage
make clean
make SOC=iMX8QM flash
</pre>

## Flashing the **flash.bin** onto SD card
* Issue:
`dd if=${SRC_ROOT}/imx-mkimage/iMX8QM/flash.bin of=/dev/<your device> bs=1K seek=32 conv=fsync status=progress`
