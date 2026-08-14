# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pedro00dk/nvidia-exec.git"
else
	SRC_URI="https://github.com/pedro00dk/nvidia-exec/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GPU switching without log out for Nvidia Optimus laptops under Linux"
HOMEPAGE="https://github.com/pedro00dk/nvidia-exec"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-lang/python
	sys-apps/lshw
	sys-process/lsof
	x11-drivers/nvidia-drivers
"

src_install() {
	newbin "${S}/nvx.py" nvx
	systemd_dounit "${S}/nvx.service"
	newinitd "${FILESDIR}/nvx.initd" nvx
	insinto /usr/lib/modprobe.d
	newins "${S}/nvx-modprobe.conf" nvx.conf
	insinto /etc/
	newins "${S}/nvx-options.conf" nvx.conf
}

pkg_postinst() {
	elog "To enable nvx at boot:"
	elog "  OpenRC:   rc-update add nvx default"
	elog "  systemd:  systemctl enable --now nvx"
	elog ""
	elog "The nvx service prevents nvidia modules from loading and turns off the graphics card during boot."
	elog "It is not necessary to handle files, configurations, PCI buses, etc, all that is done automatically."
}
