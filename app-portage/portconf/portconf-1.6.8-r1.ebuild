# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="/etc/portage cleaner"
HOMEPAGE="https://github.com/megabaks/portconf"
SRC_URI="https://github.com/megabaks/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	app-portage/eix
	app-portage/portage-utils
	dev-libs/tre
"

src_install() {
	default

	dobin portconf
	insinto /etc
	doins portconf.conf
}
