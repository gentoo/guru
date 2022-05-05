# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins,libmpv"
inherit mpv-plugin toolchain-funcs

COMMIT="769b83b82c3bb749dd7878ca23e919cb5329ea64"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="Disable the notifications while mpv is running"
HOMEPAGE="https://gitlab.com/smaniottonicola/kde-do-not-disturb"

SRC_URI="https://gitlab.com/smaniottonicola/${PN}/-/archive/${COMMIT}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
KEYWORDS="~amd64"

BDEPEND="
	dev-qt/qtdbus
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"

MPV_PLUGIN_FILES=( ${PN}.so )

src_compile() {
	emake CXX="$(tc-getCXX)" PKG_CONFIG="$(tc-getPKG_CONFIG)"
}
