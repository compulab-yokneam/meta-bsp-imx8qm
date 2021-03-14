FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8qm:"

include compulab/imx8qm.inc

KERNEL_MODULE_AUTOLOAD += "goodix"
COMPATIBLE_MACHINE_cl-som-imx8max = "(cl-som-imx8max)"

DEPENDS += "firmware-imx"
