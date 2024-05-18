# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_P="${PN}-v${PV}"
DESCRIPTION="C++ blurhash encoder/decoder"
HOMEPAGE="https://nheko.im/nheko-reborn/blurhash"
SRC_URI="https://nheko.im/nheko-reborn/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="Boost-1.0"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/doctest )"

src_configure() {
	local -a emesonargs=(
		$(meson_use test tests)

		# https://bugs.gentoo.org/921619
		-Dexamples=true
	)
	meson_src_configure
}
