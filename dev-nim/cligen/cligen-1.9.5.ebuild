# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Infer & generate command-line interface/option/argument parser"
HOMEPAGE="
	https://c-blake.github.io/cligen/
	https://github.com/c-blake/cligen
"
SRC_URI="https://github.com/c-blake/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="test toml"
RESTRICT="!test? ( test )"

RDEPEND="toml? ( dev-nim/parsetoml )"
DEPEND="${RDEPEND}
	test? ( dev-nim/parsetoml )
"

DOCS=( configs {MOTIVATION,README,RELEASE-NOTES,TODO}.md )

set_package_url "https://github.com/c-blake/cligen"

src_test() {
	emake test V=1 NIM_EXTRA="--processing:off"
}

src_install() {
	docompress -x /usr/share/doc/${PF}/examples
	dodoc -r examples

	nimble_src_install
}
