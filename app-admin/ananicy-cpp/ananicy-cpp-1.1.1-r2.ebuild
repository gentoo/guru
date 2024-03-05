# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Ananicy rewritten in C++ for much lower CPU and memory usage"
HOMEPAGE="https://gitlab.com/ananicy-cpp/ananicy-cpp"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

SRC_URI="https://gitlab.com/ananicy-cpp/ananicy-cpp/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

DEPEND="
	!app-admin/ananicy
	>=dev-cpp/nlohmann_json-3.9
	>=dev-libs/libfmt-8
	>=dev-libs/spdlog-1.9
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-remove-debug-flags.patch"
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_SYSTEMD=$(usex systemd)
		-DUSE_EXTERNAL_FMTLIB=ON
		-DUSE_EXTERNAL_JSON=ON
		-DUSE_EXTERNAL_SPDLOG=ON
		-DVERSION=${PV}
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if ! use systemd ; then
		doinitd "${FILESDIR}/${PN}.initd"
	fi

	keepdir /etc/ananicy.d
}
