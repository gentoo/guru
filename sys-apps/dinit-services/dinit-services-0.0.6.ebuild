# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Set of dinit services and helpers"
HOMEPAGE="https://codeberg.org/gentoo-dinit/services"
LICENSE="BSD-2"
SLOT=0

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/gentoo-dinit/services.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://codeberg.org/gentoo-dinit/services/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/services"
fi

IUSE="kmscon +dbus cryptsetup"

RDEPEND="
	virtual/udev
	sys-apps/sed
	kmscon? (
		sys-apps/kmscon
	)
	cryptsetup? (
		app-crypt/cryptsetup-scripts-dinit
	)
	dbus? (
		sys-apps/dbus
	)
"
DEPEND="${RDEPEND}"

src_install() {
	emake \
		$(usev kmscon TTY=kmscon) \
		$(usev cryptsetup ENABLE_CRYPTSETUP=yes) \
		$(usev dbus ENABLE_DBUS=yes) \
		DESTDIR="${D}" \
		install
	keepdir /var/log/dinit
}

pkg_postinst() {
	ewarn "dinit is not an offically supported init system"
	ewarn "expect things to break or be broken"
	ewarn "open bugs at https://codeberg.org/gentoo-dinit/services"
}
