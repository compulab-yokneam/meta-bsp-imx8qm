FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8qm:"

include compulab/imx8qm.inc

UBOOT_SRC = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2020.04_5.4.70_2.3.0"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH} \
"
SRCREV = "e42dee801ec55bc40347cbb98f13bfb5899f0368"

LOCALVERSION = "-5.4.70-2.3.0"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

RDEPENDS_${PN} += "bash"

RPROVIDES_${PN} += "u-boot-fw-utils"
