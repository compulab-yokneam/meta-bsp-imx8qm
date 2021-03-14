SRC_URI_append_cl-som-imx8max = " \
	file://0001-gpio-pca953x-add-suuport-for-exar-xra1201.patch \
	file://0002-rtc-em3027-correct-month-value.patch \
	file://0003-arch-arm64-imx8qm-cl-som-imx8max-add-basic-support.patch \
	file://0004-drm-panel-Add-support-for-Startek-KD050HDFIA020-C020.patch \
	file://0005-arch-arm64-imx8qm-cl-som-imx8max-enable-MIPI-DSI-pan.patch \
	file://0006-arch-arm64-imx8qm-cl-som-imx8max-enable-DSI-to-HDMI-.patch \
	file://0007-arch-arm64-imx8qm-cl-som-imx8max-enable-DisplayPort.patch \
	file://0008-arch-arm64-imx8qm-cl-som-imx8max-add-defconfig.patch \
	file://defconfig \
"

DEFAULT_DEFCONFIG_cl-som-imx8max = "compulab_imx8max"

do_configure_append () {
    oe_runmake ${DEFAULT_DEFCONFIG}_defconfig
}
