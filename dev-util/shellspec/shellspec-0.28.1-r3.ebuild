# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="A full-featured BDD unit testing framework for all POSIX shells"
HOMEPAGE="https://shellspec.info/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/shellspec/shellspec.git"
else
	SRC_URI="https://github.com/shellspec/shellspec/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	|| (
		>=app-shells/bash-2.03
		>=app-shells/dash-0.5.4
		app-shells/ksh
		app-shells/loksh
		>=app-shells/mksh-28r
		>=app-shells/posh-0.3.14
		>=app-shells/yash-2.29
		>=app-shells/zsh-3.1.9
		>=sys-apps/busybox-1.20.0
	)
"

BDEPEND="test? ( ${RDEPEND} )"

PATCHES=( "${FILESDIR}/${P}-fix-tests.patch" )

DOCS=(
	CHANGELOG.md
	CONTRIBUTING.md
	README.md
)

src_prepare() {
	default

	sed -i "s/lib/$(get_libdir)/" stub/shellspec || die
	sed -i "s/LICENSE//g" Makefile || die

	local to_analyze=(
		examples
		helper
		lib
		libexec
		stub/shellspec
		shellspec
	)

	local -a to_prefixify

	readarray -t to_prefixify < <(find "${to_analyze[@]}" -type f) || die
	hprefixify "${to_prefixify[@]}"
	sed -i "s|#!|#!${EPREFIX}|" README.md || die
}

src_compile() { :; }

src_test() {
	emake test
}

src_install() {
	einstalldocs

	use doc && dodoc -r docs
	use examples && dodoc -r examples

	emake LIBDIR="${ED}/usr/$(get_libdir)" PREFIX="${ED}/usr" install
}
