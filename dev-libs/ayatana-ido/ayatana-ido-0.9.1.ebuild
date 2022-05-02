# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake vala

DESCRIPTION="Ayatana Application Indicators (Shared Library)"
HOMEPAGE="https://github.com/AyatanaIndicators/ayatana-ido"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/glibc \
	>=dev-libs/glib-2.58 \
	>=x11-libs/gtk+-3.24 \
	"

BDEPEND="
	${RDEPEND} \
	$(vala_depend) \
	>=dev-util/cmake-3.13 \
	dev-libs/gobject-introspection \
	"

src_prepare() {
	cmake_src_prepare
	vala_setup
}

src_configure() {
	local mycmakeargs+=(
		"-DVALA_COMPILER=${VALAC}"
		"-DVAPI_GEN=${VAPIGEN}"
		)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}
