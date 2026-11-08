# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake systemd

DESCRIPTION="Linux multi-touch gesture recognizer"
HOMEPAGE="https://github.com/JoseExposito/touchegg/"

SRC_URI="https://github.com/JoseExposito/touchegg/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput:=
	dev-libs/pugixml
	virtual/libudev
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXtst
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Bump cmake version
	sed -e '/^cmake_minimum_required(/s/[0-9\.]\+/4.0/' \
		-i CMakeLists.txt || die
	# We define this variable ourselves
	sed -e '/pkg_get_variable(SYSTEMD_SERVICE_DIR /d' \
		-i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"

		# Always install service scripts
		-DUSE_SYSTEMD=ON
		-DSYSTEMD_SERVICE_DIR="$(systemd_get_systemunitdir)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	newinitd "${FILESDIR}/touchegg.initd" touchegg
}
