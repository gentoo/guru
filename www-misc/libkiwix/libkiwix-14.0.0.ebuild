# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit meson python-any-r1

DESCRIPTION="Kiwix software suite core: code shared by all Kiwix ports"
HOMEPAGE="https://kiwix.org/"
SRC_URI="https://github.com/kiwix/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0/14"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=app-arch/libzim-9.0.0
	dev-libs/icu:=
	dev-libs/pugixml
	dev-libs/xapian:=
	net-libs/libmicrohttpd:=
	net-misc/curl
	sys-libs/zlib
"
RDEPEND="
	${COMMON_DEPEND}
	net-misc/aria2[bittorrent,metalink,xmlrpc]
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-cpp/mustache-4.1
"
BDEPEND="
	${PYTHON_DEPS}
	test? ( dev-cpp/gtest )
"

src_prepare() {
	default

	# requires PROPERTIES="test_network"
	sed -i '/^if build_machine.system/,/endif/d' test/meson.build || die

	if ! use test; then
		sed -i "/subdir('test')/d" meson.build || die
	fi
}
