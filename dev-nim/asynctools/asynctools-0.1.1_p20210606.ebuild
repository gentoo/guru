# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

COMMIT="84ced6d002789567f2396c75800ffd6dff2866f7"
DESCRIPTION="Various asynchronous tools for Nim language"
HOMEPAGE="
	https://github.com/cheatfate/asynctools
	https://nimble.directory/pkg/asynctools
"
SRC_URI="https://github.com/cheatfate/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-3)"
KEYWORDS="~amd64"

set_package_url "https://github.com/cheatfate/asynctools"

src_prepare() {
	default

	# disable tests that require network
	sed "/asyncdns/d" -i ${PN}.nimble || die
}
