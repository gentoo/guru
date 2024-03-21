# Copyright 2020, 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

MY_P="solo1-${PV}"
DESCRIPTION="udev rules for the Solo FIDO2 & U2F USB+NFC security key"
HOMEPAGE="
	https://solokeys.com/
	https://github.com/solokeys/solo1
"
SRC_URI="https://github.com/solokeys/solo1/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# Omitting src_compile() would invoke make, leaving it empty is not allowed.
	:
}

src_install() {
	udev_dorules udev/70-solokeys-access.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
