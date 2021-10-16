# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Good-lookin' diffs. Actually... nah... The best-lookin' diffs"
HOMEPAGE="https://github.com/so-fancy/diff-so-fancy"
SRC_URI="https://github.com/so-fancy/diff-so-fancy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-lang/perl
	test? (
		dev-util/bats-assert
		dev-util/bats-support
	)
"
BDEPEND="test? ( dev-util/bats )"

PATCHES=(
	"${FILESDIR}/fix-path.patch"
	"${FILESDIR}/${P}-system-bats.patch"
)
DOCS=( README.md history.md pro-tips.md )
RESTRICT="!test? ( test )"

src_install() {
	dobin "${PN}"

	insinto "/usr/share/${PN}"
	doins lib/*

	einstalldocs
}

src_test() {
	# it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die

	bats test || die
}
