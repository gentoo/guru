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
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/PurritoBin-${PV}"
fi

LICENSE="ISC"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	net-libs/usockets[ssl]
	acct-user/purritobin
	acct-group/purritobin
"
DEPEND="${RDEPEND}
	www-apps/uwebsockets
"

src_configure() {
	default
	tc-export CXX
}

src_test() {
	emake check
}

src_install() {
	emake PREFIX="/usr" MANDIR="/usr/share/man" DESTDIR="${ED}" install
	insinto /var/www/purritobin
	doins frontend/paste.html
	fowners purritobin:purritobin /var/www/purritobin
	newinitd "${FILESDIR}"/purritobin.initd purritobin
	systemd_dounit "${FILESDIR}"/purritobin.service
	einstalldocs
}
