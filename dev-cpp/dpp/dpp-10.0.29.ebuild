# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lightweight C++ Discord bot library"
HOMEPAGE="https://dpp.dev/ https://github.com/brainboxdotcc/DPP"
SRC_URI="
	https://github.com/brainboxdotcc/DPP/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Apache-2.0"
# DPP is extremely ABI instable due to frequent changes in the Discord API
# See https://github.com/brainboxdotcc/DPP/issues/207#issuecomment-1007030157
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="voice"

RDEPEND="
	dev-libs/openssl:=
	sys-libs/zlib:=

	voice? (
		dev-libs/libsodium:=
		media-libs/opus
	)
"
DEPEND="
	${RDEPEND}

	dev-cpp/nlohmann_json
"

S="${WORKDIR}/DPP-${PV}"

DOCS=( "README.md" "SECURITY.md" )

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=true
		-DBUILD_VOICE_SUPPORT="$(usex voice)"
		-DRUN_LDCONFIG=false
		# Tests require network access
		-DDPP_BUILD_TEST=false
		-DDPP_NO_VCPKG=true
		-DDPP_USE_EXTERNAL_JSON=true
	)

	cmake_src_configure
}
