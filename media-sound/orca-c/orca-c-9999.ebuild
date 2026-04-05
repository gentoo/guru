# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Live Programming Environment(C Port)"
HOMEPAGE="
	https://wiki.xxiivv.com/site/orca.html
	https://github.com/hundredrabbits/Orca-c
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hundredrabbits/Orca-c.git"
else
	GIT_COMMIT=9df9786e2ad3c01955cdf4cdd5ae1fffad8fa5cc
	MY_PN="Orca-c"
	SRC_URI="https://github.com/hundredrabbits/${MY_PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/"${MY_PN}-${GIT_COMMIT}"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="doc examples +mouse portmidi static hardened"

DEPEND="
	static? (
		sys-libs/ncurses[static-libs]
	)
	!static? (
		sys-libs/ncurses
	)
	portmidi? (
		media-libs/portmidi
	)
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

DOCS=(
	"README.md",
	examples
)

src_compile() {
	compile_options=(
		$(usev static --static)
		$(usev hardened --harden)
		$(usex portmidi '--portmid' '--no-portmidi')
		$(usex mouse '--mouse' '--no-mouse')
	)

	#sed --in-place --expression='s/ -g0//g' ./tool
	#sed --in-place --expression='s/ -DNDEBUG//g' ./tool
	sed --in-place --expression='s/-flto -s/-flto/g' ./tool

	./tool build ${compile_options[@]} orca
}

src_install() {
	exeinto /usr/bin
	doexe build/orca

	use doc && dodoc README.md
	if use examples; then
		docinto examples
		dodoc -r examples
	fi
}
