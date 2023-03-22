# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Infer & generate command-line interface/option/argument parser"
HOMEPAGE="
	https://github.com/c-blake/cligen
	https://nimble.directory/pkg/cligen
"
SRC_URI="https://github.com/c-blake/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="examples"

# very fragile tests
RESTRICT="test"

DOCS=( configs {MOTIVATION,README,RELEASE-NOTES,TODO}.md )

set_package_url "https://github.com/c-blake/cligen"

src_prepare() {
	default

	# verbose makefile
	sed "s/\t@/\t/g" -i GNUmakefile || die
}

src_test() {
	emake
}

src_install() {
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi

	nimble_src_install
}
