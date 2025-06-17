# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature shell-completion

DESCRIPTION="A cross-platform build utility based on Lua"
HOMEPAGE="https://xmake.io"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xmake-io/${PN}.git"
else
	SRC_URI="https://github.com/xmake-io/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64 ~riscv ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
# tarball doesn't provide tests
RESTRICT="test"

DEPEND="
	sys-libs/ncurses:=
	sys-libs/readline:=
"
BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	${DEPEND}
	${BDEPEND}
"

DOCS=(
	CHANGELOG.md CODE_OF_CONDUCT.md CONTRIBUTING.md
	NOTICE.md README.md README_zh.md
)

src_prepare() {
	default

	# Don't strip binaries
	sed -i 's/"-s"/""/' configure || die
}

src_configure() {
	econf --prefix="${EPREFIX}"/usr \
		--plat=linux
		# --plat=linux is necessary, which enables correct directory:
		# build/linux/ARCH other than build/ARCH/ARCH
}

src_install() {
	default

	doman scripts/man/*

	newbashcomp xmake/scripts/completions/register-completions.bash xmake
	bashcomp_alias xmake xrepo
	newzshcomp xmake/scripts/completions/register-completions.zsh _xmake
	newfishcomp xmake/scripts/completions/register-completions.fish xmake.fish
}

pkg_postinst() {
	optfeature "cached compilation for your xmake projects" dev-util/ccache
}
