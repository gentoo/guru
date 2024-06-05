# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins(+),libmpv"
inherit mpv-plugin toolchain-funcs

COMMIT="478b805b30d4aab41eeb4b2018ab1c8bb0c22c7d"
MY_P="${PN}-${COMMIT}"
DESCRIPTION="Disable the notifications while mpv is running"
HOMEPAGE="https://gitlab.com/smaniottonicola/kde-do-not-disturb"
SRC_URI="https://gitlab.com/smaniottonicola/${PN}/-/archive/${COMMIT}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="Unlicense"
KEYWORDS="~amd64"

BDEPEND="
	dev-qt/qtdbus:5
	virtual/pkgconfig
"

MPV_PLUGIN_FILES=( ${PN}.so )

src_compile() {
	emake CXX="$(tc-getCXX)" PKG_CONFIG="$(tc-getPKG_CONFIG)"
}
