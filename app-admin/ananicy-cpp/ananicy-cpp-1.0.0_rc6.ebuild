# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="${PV/_rc/-rc}"

inherit cmake

DESCRIPTION="Ananicy rewritten in C++ for much lower CPU and memory usage"
HOMEPAGE="https://gitlab.com/ananicy-cpp/ananicy-cpp"
SRC_URI="https://gitlab.com/ananicy-cpp/ananicy-cpp/-/archive/v${MYPV}/${PN}-v${MYPV}.tar.bz2"
S="${WORKDIR}/${PN}-v${MYPV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libfmt
	dev-libs/spdlog
	systemd? ( sys-apps/systemd )
"
DEPEND="
	${RDEPEND}
	dev-cpp/std-format
"

PATCHES=(
	"${FILESDIR}/${P}-system-std-format.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_SYSTEMD=$(usex systemd)
		-DUSE_EXTERNAL_FMTLIB=ON
		-DUSE_EXTERNAL_JSON=ON
		-DUSE_EXTERNAL_SPDLOG=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	doinitd "${FILESDIR}/${PN}.initd"
}
