# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="minimalistic commandline pastebin"
HOMEPAGE="https://bsd.ac"

inherit systemd toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PurritoBin/PurritoBin.git"
else
	SRC_URI="https://github.com/PurritoBin/PurritoBin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/PurritoBin-${PV}"
fi

LICENSE="ISC"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-db/lmdb-0.9.29
	net-libs/usockets[ssl]
	acct-user/purritobin
	acct-group/purritobin
"
DEPEND="${RDEPEND}
	www-apps/uwebsockets
	>=dev-db/lmdb++-1.0.0
"
BDEPEND="test? ( sys-apps/coreutils )"

src_configure() {
	default
	tc-export CXX
}

src_test() {
	P_DD_FLAGS="iflag=fullblock" \
	default
}

src_install() {
	emake PREFIX="/usr" MANDIR="/usr/share/man" DESTDIR="${ED}" install
	insinto /var/www/purritobin
	doins frontend/paste.html
	keepdir /var/db/purritobin
	fowners purritobin:purritobin /var/www/purritobin /var/db/purritobin
	newinitd services/openrc purritobin
	systemd_newunit services/systemd purritobin.service
	einstalldocs
}
