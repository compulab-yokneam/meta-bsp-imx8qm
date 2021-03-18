# Building Linux Kernel for CompuLab's i.MX8 QuadMax products

Supported machines:

* `cl-som-imx8max`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|cl-som-imx8max|export MACHINE=cl-som-imx8max

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=rel_imx_5.4.47_2.2.0|
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
</pre>
* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8qm.git
export PATCHES=$(pwd)/meta-bsp-imx8qm/recipes-kernel/linux/compulab/imx8qm
</pre>

## CompuLab Linux Kernel setup
<pre>
git clone https://source.codeaurora.org/external/imx/linux-imx.git
git -C linux-imx checkout -b linux-${MACHINE} ${NXP_RELEASE}
git -C linux-imx am ${PATCHES}/*.patch
</pre>

## Compile the Kernel
<pre>
make -C linux-imx compulab_imx8max_defconfig
make -C linux-imx
</pre>
