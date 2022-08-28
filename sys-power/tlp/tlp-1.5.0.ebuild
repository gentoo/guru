# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev optfeature

DESCRIPTION="Optimize laptop battery life"
HOMEPAGE="https://linrunner.de/tlp/"
SRC_URI="https://github.com/linrunner/TLP/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/TLP-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion elogind systemd"
RESTRICT="mirror"
RDEPEND="virtual/udev
		bash-completion? ( app-shells/bash app-shells/bash-completion )
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}"
REQUIRED_USE="?? ( elogind systemd )"

src_install() {
	emake \
		DESTDIR="${D}" \
		TLP_NO_INIT=1 \
		TLP_NO_BASHCOMP=$(usex bash-completion 0 1) \
		TLP_WITH_ELOGIND=$(usex elogind 1 0) \
		TLP_WITH_SYSTEMD=$(usex systemd 1 0) \
		install install-man

	chmod 444 "${D}/usr/share/tlp/defaults.conf" # manpage says this file should not be edited
	newinitd "${FILESDIR}/tlp.init" tlp
	keepdir "/var/lib/tlp" # created by Makefile, probably important
}

pkg_postinst() {
	udev_reload

	optfeature "disable Wake-on-LAN" sys-apps/ethtool
	optfeature "see disk drive health info in tlp-stat" sys-apps/smartmontools
}

pkg_postrm() {
	udev_reload
}
