# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Search in commons.wikimedia.org by hash (sha1) of provided file"
HOMEPAGE="https://gitlab.com/vitaly-zdanevich/commons-wikimedia-find-by-hash"
SRC_URI="https://gitlab.com/vitaly-zdanevich/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="
	net-misc/curl
	app-misc/jq
"

src_install() {
	dobin "${PN}".sh
}
