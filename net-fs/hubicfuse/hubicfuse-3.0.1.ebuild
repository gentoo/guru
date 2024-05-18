# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Support for mounting HubiC drive in GNU/Linux"
HOMEPAGE="https://github.com/TurboGit/hubicfuse"
SRC_URI="https://github.com/TurboGit/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~x86"

DEPEND="
	net-misc/curl
	dev-libs/openssl:0=
	sys-fs/fuse:0
	sys-apps/file
	dev-libs/libxml2
	dev-libs/json-c
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_configure() {
	append-cflags -fcommon
	default
}

src_install() {
	default

	dobin hubic_token

	ewarn "The hubiC service is now closed to new subscriptions:"
	ewarn "https://www.ovh.co.uk/subscriptions-hubic-ended/"
	ewarn "Make sure that you already have hubiC account."
}
