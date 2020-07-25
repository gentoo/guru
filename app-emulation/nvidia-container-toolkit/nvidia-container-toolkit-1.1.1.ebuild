# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GITHUB_PN="container-toolkit"
EGO_PN_VCS="github.com/NVIDIA/${GITHUB_PN}"
EGO_PN="${EGO_PN_VCS}"

inherit golang-build

DESCRIPTION="NVIDIA container runtime toolkit"
HOMEPAGE="https://github.com/NVIDIA/nvidia-container-toolkit"

if [[ "${PV}" == "9999" ]] ; then
	inherit golang-vcs
else
	inherit golang-vcs-snapshot
	SRC_URI="
		https://github.com/NVIDIA/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE=""

RDEPEND="
	sys-libs/libnvidia-container
"

DEPEND="${RDEPEND}"

BDEPEND=""

src_compile() {
	EGO_PN="${EGO_PN_VCS}/pkg" \
		EGO_BUILD_FLAGS="-o ${T}/${PN}" \
		golang-build_src_compile
}

src_install() {
	dobin "${T}/${PN}"
	into "/usr/bin"
	dosym "${PN}" "/usr/bin/nvidia-container-runtime-hook"
	insinto "/etc/nvidia-container-runtime"
	doins "${FILESDIR}/config.toml"
}

pkg_postinst() {
	elog "Your docker service must restart after install this package."
	elog "OpenRC: sudo rc-service docker restart"
	elog "systemd: sudo systemctl restart docker"
	elog "You may need to edit your /etc/nvidia-container-runtime/config.toml"
	elog "file before running ${PN} for the first time."
	elog "For details, please see the NVIDIA docker manual page."
}
