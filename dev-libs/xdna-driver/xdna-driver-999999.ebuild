# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

# FWAPI=https://gitlab.com/api/v4/projects/kernel-firmware%2Fdrm-firmware/repository/branches/amd-ipu-staging
# curl -s "$FWAPI" | jq -r '.commit.id'
FW_HASH=886e8948d60c354b488ad8d10c56763b81597093

DESCRIPTION="AMD XDNA Driver"
HOMEPAGE="https://github.com/amd/xdna-driver"

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/amd/xdna-driver.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/amd/xdna-driver/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi

# INFO_FILE=https://raw.githubusercontent.com/amd/xdna-driver/main/tools/info.json
# curl -s "$INFO_FILE" | jq -r '.firmwares[] | "\(.url) -> \(.pci_device_id)_\(.pci_revision_id)__\(.fw_name)"'
FW_URI_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/${FW_HASH}/amdnpu
SRC_URI+=" firmware? (
	${FW_URI_PREFIX}/1502_00/npu.sbin.1.5.5.391 -> ${FW_HASH:0:6}-1502_00__npu.dev.sbin
	${FW_URI_PREFIX}/17f0_00/npu.sbin.0.7.22.185 -> ${FW_HASH:0:6}-17f0_00__npu.dev.sbin
	${FW_URI_PREFIX}/17f0_10/npu.sbin.255.0.5.35 -> ${FW_HASH:0:6}-17f0_10__npu.dev.sbin
	${FW_URI_PREFIX}/17f0_11/npu.sbin.255.0.5.35 -> ${FW_HASH:0:6}-17f0_11__npu.dev.sbin
)"

declare -A firmwares

# curl -s https://raw.githubusercontent.com/amd/xdna-driver/main/tools/info.json \
# | jq -r '.firmwares[] | "firmwares[\"\(.pci_device_id)_\(.pci_revision_id)__\(.fw_name)\"]=\(.pci_device_id)_\(.pci_revision_id)/\(.fw_name)"'
firmwares["1502_00__npu.dev.sbin"]=1502_00/npu.dev.sbin
firmwares["17f0_00__npu.dev.sbin"]=17f0_00/npu.dev.sbin
firmwares["17f0_10__npu.dev.sbin"]=17f0_10/npu.dev.sbin
firmwares["17f0_11__npu.dev.sbin"]=17f0_11/npu.dev.sbin

S="${WORKDIR}/${P}/src/driver/amdxdna"
LICENSE="GPL-2 firmware? ( linux-fw-redistributable )"
SLOT="0"
IUSE="+firmware"

src_prepare() {
	sed -e "s/-Werror//" -i Kbuild || die
	default
}

src_compile() {
	local modlist=( amdxdna )
	local modargs=( KERNEL_VER="${KV_FULL}" )

	linux-mod-r1_src_compile
}

src_install() {
	for k in "${!firmwares[@]}"; do
		value="${firmwares[$k]}"
		mkdir -p "${D}/lib/firmware/amdnpu/$(dirname "${value}")" || die
		cp "${DISTDIR}/${FW_HASH:0:6}-$k" "${D}/lib/firmware/amdnpu/${value}" || die
	done

	insinto /usr/lib/modules-load.d
	newins - amdxdna.conf <<-EOF
		amdxdna
	EOF

	insinto /etc/modprobe.d
	newins - amdxdna.conf <<-EOF
		install amdxdna /sbin/insmod /lib/modules/\$(uname -r)/extra/amdxdna.ko \$CMDLINE_OPTS
	EOF

	linux-mod-r1_src_install
}
