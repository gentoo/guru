# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="a Nim implementation of linenoise"
HOMEPAGE="
	https://github.com/jangko/nim-noise
	https://nimble.directory/pkg/noise
"
SRC_URI="https://github.com/jangko/nim-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/nim-${P}"

LICENSE="MIT"
SLOT="0.1.4"
KEYWORDS="~amd64"

DOCS=( examples readme.md )

set_package_url "https://github.com/jangko/nim-noise"

src_test() {
	nimble_src_test
	rm examples/{primitives,test} || die
}

src_install() {
	docompress -x /usr/share/doc/${PF}/examples
	nimble_src_install
}
