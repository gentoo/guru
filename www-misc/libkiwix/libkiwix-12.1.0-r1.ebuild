# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Kiwix software suite core: code shared by all Kiwix ports"
HOMEPAGE="https://kiwix.org/"
SRC_URI="https://github.com/kiwix/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libkiwix-${PV}"

LICENSE="GPL-3"
SLOT="0/12"
KEYWORDS="~amd64"

RDEPEND="
	net-misc/aria2[bittorrent,metalink,xmlrpc]
"

DEPEND="
	>=app-arch/libzim-8.1.0:=
	>=dev-cpp/mustache-4.1
	dev-libs/icu
	dev-libs/pugixml
	net-libs/libmicrohttpd
	net-misc/curl
	sys-libs/zlib
"

src_prepare() {
	default

	# disable tests
	sed -i \
		-e "/subdir('test')/d" \
		meson.build || die
}

src_configure() {
	local emesonargs=(
		-Dwerror=false
	)

	meson_src_configure
}
