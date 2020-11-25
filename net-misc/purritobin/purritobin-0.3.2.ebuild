# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="minimalistic commandline pastebin"
HOMEPAGE="https://bsd.ac"

inherit toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PurritoBin/PurritoBin.git"
else
	SRC_URI="https://github.com/PurritoBin/PurritoBin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/PurritoBin-${PV}"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="net-libs/usockets[ssl]"
DEPEND="${RDEPEND}
	www-apps/uwebsockets
"

src_configure() {
	default
	tc-export CXX
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${ED}" install
	einstalldocs
}
