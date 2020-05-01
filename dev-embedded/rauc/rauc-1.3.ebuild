# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCBUILDER="sphinx"
DOCDIR="${S}/docs"

inherit autotools docs

DESCRIPTION="Lightweight update client that runs on your Embedded Linux device"
HOMEPAGE="https://rauc.io/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="json network service test"

RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
	test? ( sys-fs/squashfs-tools )
"
RDEPEND="
	dev-libs/glib:2
	dev-libs/openssl:0=
	json? ( dev-libs/json-glib )
	network? ( net-misc/curl )
	service? ( sys-apps/dbus )
"
DEPEND="
	${RDEPEND}
"

PATCHES=( "${FILESDIR}/${P}-tests.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable json)
		$(use_enable network)
		$(use_enable service)
	)
	econf "${myconf[@]}"
}
