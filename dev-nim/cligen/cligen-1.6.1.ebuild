# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Infer & generate command-line interface/option/argument parser"
HOMEPAGE="
	https://c-blake.github.io/cligen/
	https://nimble.directory/pkg/cligen
	https://github.com/c-blake/cligen
"
SRC_URI="https://github.com/c-blake/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="examples"

DOCS=( configs {MOTIVATION,README,RELEASE-NOTES,TODO}.md )

set_package_url "https://github.com/c-blake/cligen"

src_prepare() {
	default

	# verbose makefile
	sed "s/\t@/\t/g" -i GNUmakefile || die
}

src_test() {
	emake NIM_FLAGS="--hints:off --warning:all:off --warning:User:on --colors:off"
}

src_install() {
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi

	nimble_src_install
}
