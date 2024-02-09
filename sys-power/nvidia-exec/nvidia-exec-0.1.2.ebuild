# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit  systemd

SRC_URI="https://github.com/pedro00dk/nvidia-exec/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="Lenovo Legion Linux kernel module"
HOMEPAGE="https://github.com/pedro00dk/nvidia-exec"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"

src_install() {
	dobin "${WORKDIR}/${P}/nvx"
	insinto /usr/lib/systemd/system-sleep
	doins "${WORKDIR}/${P}/nvx-suspend-restore"
	systemd_dounit "${WORKDIR}/${P}/nvx.service"
	insinto /usr/lib/modprobe.d
	newins "${WORKDIR}/${P}/modprobe.conf" nvx.conf
}

pkg_postinst() {
	ewarn "Don't forget to reload dbus to enable \"nvx\" service, \
by runnning:\n \`systemctl daemon-reload && systemctl enable --now nvx\`\n"
}
