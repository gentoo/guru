# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DOCS_BUILDER="sphinx"
DOCS_DIR="${S}/docs"

inherit meson python-any-r1 docs

DESCRIPTION="Lightweight update client that runs on your Embedded Linux device"
HOMEPAGE="https://rauc.io/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE="gpt json network service test"

RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPS}
	dev-util/gdbus-codegen
	virtual/pkgconfig
	doc? (
		$(python_gen_any_dep '
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
	test? (
		dev-libs/opensc
		net-misc/casync
		sys-fs/mtd-utils
		sys-fs/squashfs-tools
		sys-libs/libfaketime
	)
"
RDEPEND="
	dev-libs/glib:2
	dev-libs/libnl:3=
	dev-libs/openssl:0=
	json? ( dev-libs/json-glib )
	network? ( net-misc/curl )
	service? ( sys-apps/dbus )
"
DEPEND="
	${RDEPEND}
"

PATCHES=( "${FILESDIR}/${P}-tests.patch" )

src_configure() {
	local emesonargs=(
		$(meson_feature gpt)
		$(meson_feature json)
		$(meson_use network)
		$(meson_use network streaming)
		$(meson_use service)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
	docs_compile
}
