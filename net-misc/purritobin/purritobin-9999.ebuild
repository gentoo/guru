# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="minimalistic commanline pastebin"
HOMEPAGE="https://bsd.ac"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PurritoBin/PurritoBin.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/PurritoBin/PurritoBin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/PurritoBin-${PV}"
fi

LICENSE="ISC"
SLOT="0"
IUSE="libuv"

DEPEND=">=dev-cpp/usockets-0.3.5:=[libuv?]
	>=dev-cpp/uwebsockets-0.17.4
	libuv? ( >=dev-libs/libuv-1.35.0 )
"
RDEPEND="${DEPEND}"

src_compile() {
	if use libuv; then
		WITH_LIBUV=1 emake all
	else
		emake all
	fi
}

src_install() {
	emake prefix="/usr" DESTDIR="${D}" install
	einstalldocs
}
