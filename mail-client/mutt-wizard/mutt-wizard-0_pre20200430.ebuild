# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A system for automatically configuring mutt and isync"
HOMEPAGE="https://github.com/LukeSmithxyz/mutt-wizard"

COMMIT=069910c13ec1c89421372b8e54b40cd2ae783303
SRC_URI="https://github.com/LukeSmithxyz/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
IUSE="+notmuch +lynx"

RDEPEND="
	mail-client/neomutt:=[notmuch=]
	net-mail/isync:=[ssl]
	mail-mta/msmtp
	app-admin/pass
	lynx? ( www-client/lynx )
"

# needed because there is no 'all' target defined in MAKEFILE
src_compile() {
	return 0;
}

src_install() {
	# Do not install to /usr/local
	PREFIX="/usr" default
}
