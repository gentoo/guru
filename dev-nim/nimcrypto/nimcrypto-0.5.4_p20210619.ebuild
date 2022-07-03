# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs nimble

COMMIT="a5742a9a214ac33f91615f3862c7b099aec43b00"
DESCRIPTION="Nim cryptographic library"
HOMEPAGE="
	https://github.com/cheatfate/nimcrypto
	https://nimble.directory/pkg/nimcrypto
"
SRC_URI="https://github.com/cheatfate/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-3)"
KEYWORDS="~amd64"

CHECKREQS_MEMORY=4G

HTML_DOCS=( docs/. )

set_package_url "https://github.com/cheatfate/nimcrypto"

pkg_pretend() {
	has test ${FEATURES} && check-reqs_pkg_pretend
}

pkg_setup() {
	has test ${FEATURES} && check-reqs_pkg_setup
}

src_prepare() {
	default
	echo '--path:".."' >> tests/nim.cfg || die
}
