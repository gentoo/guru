# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="sudo shim that utilizes doas"
HOMEPAGE="https://github.com/jirutka/doas-sudo-shim"
SRC_URI="https://github.com/jirutka/doas-sudo-shim/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-admin/doas"

src_install() {
	dobin sudo
	dodoc README.adoc LICENSE
}

pkg_postinst() {
	elog "This package installs a 'sudo' script that forwards commands to doas."
	elog "It conflicts with app-admin/sudo because both provide /usr/bin/sudo."
	elog "To use this shim, either remove app-admin/sudo or mask it."
	elog "Make sure your /etc/doas.conf is configured properly."
}
