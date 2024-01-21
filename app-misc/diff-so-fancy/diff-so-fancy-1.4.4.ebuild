# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Good-lookin' diffs. Actually... nah... The best-lookin' diffs"
HOMEPAGE="https://github.com/so-fancy/diff-so-fancy"
SRC_URI="https://github.com/so-fancy/diff-so-fancy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/perl"
DEPEND="
	${RDEPEND}
	test? (
		dev-util/bats-assert
		dev-util/bats-support
	)
"
BDEPEND="
	test? (
		dev-util/bats
		dev-vcs/git
	)
"

DOCS=( README.md history.md pro-tips.md )

src_prepare() {
	default

	# fix file paths
	sed -i "s|test_helper/bats-\(.*\)/load|${EPREFIX}/usr/share/bats-\1/load.bash|" \
		test/{bugs,diff-so-fancy,git-config}.bats || die
	sed -i "s|use lib .*;|use lib \"${EPREFIX}/usr/share/diff-so-fancy\";|" diff-so-fancy || die

	# en_US locale is not always available, C is.
	sed -i "s/LC_CTYPE=.*/LC_CTYPE=C.UTF-8/" test/test_helper/util.bash || die
}

src_install() {
	dobin "${PN}"

	insinto "/usr/share/${PN}"
	doins lib/*

	einstalldocs
}

src_test() {
	PERL5LIB=lib bats test || die
}
