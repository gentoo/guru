# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit desktop python-any-r1

DESCRIPTION="Forward-port of the Crowther/Woods Adventure 2.5"
HOMEPAGE="http://www.catb.org/~esr/open-adventure/"
SRC_URI="https://gitlab.com/esr/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]' )
"

DOCS=( NEWS.adoc hints.adoc history.adoc README.adoc notes.adoc )

src_compile() {
	emake advent advent.6
}

src_install() {
	einstalldocs
	doman advent.6

	dobin advent

	doicon -s scalable advent.svg
	domenu advent.desktop
}

src_test() {
	# parallel tests often fail
	emake -j1 check
}
