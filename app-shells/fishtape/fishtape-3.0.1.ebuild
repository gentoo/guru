# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="100% pure-Fish test runner"
HOMEPAGE="https://github.com/jorgebucaran/fishtape"
SRC_URI="https://github.com/jorgebucaran/fishtape/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="app-shells/fish"
DEPEND="
	${RDEPEND}
	test? ( app-shells/fishtape )
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
	fish -c 'fishtape tests/*' || die
}
