# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://github.com/so-fancy/diff-so-fancy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Good-lookin' diffs. Actually... nah... The best-lookin' diffs."
HOMEPAGE="https://github.com/so-fancy/diff-so-fancy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
#RESTRICT="!test? ( test )"
RESTRICT="test" #investigate
RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-lang/perl
"
BDEPEND="test? ( dev-util/bats )"
PATCHES=( "${FILESDIR}/fix-path.patch" )
DOCS=( README.md history.md pro-tips.md )

src_install() {
	dobin "${PN}"

	insinto "/usr/share/${PN}"
	doins lib/*

	einstalldocs
}

src_test() {
	bats test || die
}
