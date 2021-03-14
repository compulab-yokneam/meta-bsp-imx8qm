IMX_BOOT_IMG_NAME = "${BOOT_NAME}-${MACHINE}-${UBOOT_CONFIG}"
IMX_BOOT_IMG_NAME_LONG = "${BOOT_CONFIG_MACHINE}-${target}"

do_install () {
    install -d ${D}/boot
    for target in ${IMXBOOT_TARGETS}; do
        install -m 0644 ${S}/${IMX_BOOT_IMG_NAME_LONG} ${D}/boot/${IMX_BOOT_IMG_NAME}
    done
}

COMPATIBLE_MACHINE_cl-som-imx8max = "cl-som-imx8max"
