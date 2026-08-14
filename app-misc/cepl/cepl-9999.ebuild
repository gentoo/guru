# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A readline C and C++ REPL with history, tab-completion, and undo."
HOMEPAGE="https://github.com/alyptik/cepl"
S="${WORKDIR}"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alyptik/${PN}.git"
	EGIT_SUBMODULES=('*')
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR="${S}"
else
	SRC_URI="https://github.com/alyptik/cepl/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="debug"
RDEPEND="
	sys-libs/readline:=
	virtual/libelf:=
	"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eapply_user
}

src_compile() {
	local myemakeargs=()

	tc-export CC
	export {C,LD}FLAGS

	use debug && myemakeargs+="debug"
	emake "${myemakeargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
