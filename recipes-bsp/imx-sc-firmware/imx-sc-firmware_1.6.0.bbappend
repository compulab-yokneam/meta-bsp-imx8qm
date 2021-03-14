FILESEXTRAPATHS_prepend := "${THISDIR}/firmware:"

SRC_URI += "\
    file://cl-som-imx8max-scfw-tcm.bin \
"

SC_FIRMWARE_NAME_cl-som-imx8max = "cl-som-imx8max-scfw-tcm.bin"

do_deploy() {
	install -Dm 0644 ${WORKDIR}/${SC_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME}
	ln -sf ${SC_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}/${symlink_name}
}

COMPATIBLE_MACHINE_cl-som-imx8max = "cl-som-imx8max"
