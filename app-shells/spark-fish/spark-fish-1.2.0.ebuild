# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN/-/.}"

DESCRIPTION="Sparklines for Fish"
HOMEPAGE="https://github.com/jorgebucaran/spark.fish"
SRC_URI="https://github.com/jorgebucaran/spark.fish/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="app-shells/fish"
DEPEND="
	test? (
		${RDEPEND}
		app-shells/fishtape
		app-shells/spark-fish
	)
"

DOCS=( README.md )
RESTRICT="!test? ( test )"

src_install() {
	insinto "/usr/share/fish/vendor_completions.d"
	doins completions/*
	insinto "/usr/share/fish/vendor_functions.d"
	doins functions/*
	einstalldocs
}

src_test() {
	fish -c 'fishtape ./test/spark.fish' || die
}
