# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

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
PATCHES="${FILESDIR}/${PN}-1.5.0-Makefile.patch"
CONFIG_PROTECT="/etc/tlp.conf /etc/tlp.d"

src_prepare() {
	default
	sed -i "s/@LIBDIR@/$(get_libdir)/g" "${S}/Makefile"
}

src_compile() {
	emake
}

src_install() {
	if use bash-completion; then export bashcomp=0; else export bashcomp=1; fi
	if use elogind; then export elogind=1; else export elogind=0; fi
	if use systemd; then export systemd=1; else export systemd=0; fi

	emake \
		DESTDIR="${D}" \
		TLP_NO_INIT=1 \
		TLP_NO_BASHCOMP=$bashcomp \
		TLP_WITH_ELOGIND=$elogind \
		TLP_WITH_SYSTEMD=$systemd \
		install install-man

	chmod 444 "${D}/usr/share/tlp/defaults.conf" # manpage says this file should not be edited
	newinitd "${FILESDIR}/tlp.init" tlp
	keepdir "/var/lib/tlp" # created by Makefile, probably important
}

pkg_postinst() {
	udev_reload

	elog "Consider installing these optional dependencies:"
	elog "- sys-apps/ethtool to allow disabling WoL"
	elog "- sys-apps/smartmontools for disk drive health info in tlp-stat"
}
