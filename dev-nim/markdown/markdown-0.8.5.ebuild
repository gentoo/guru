# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A Markdown Parser in Nim World"
HOMEPAGE="
	https://github.com/soasme/nim-markdown
	https://nimble.directory/pkg/markdown
"
SRC_URI="https://github.com/soasme/nim-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/nim-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

set_package_url "https://github.com/soasme/nim-markdown"

src_install() {
	nimble_src_install
	mv "${ED}"/usr/bin/{markdown,nim-markdown} || die
}
